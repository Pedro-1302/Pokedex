import UIKit

final class PokemonListVC: UIViewController {
    private let service: PokemonServiceProtocol
    private(set) var pokemonList: [Pokemon] = []
    private(set) var filteredPokemonList: [Pokemon] = []
    private(set) var pokemonCount: Int = 0

    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search by pokemon or dex number"
        return searchController
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        return tableView
    }()

    private let loadingView = LoadingView()

    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        setTableViewAsRootView()
        fetchPokemons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBarTitle()
    }
}

// MARK: - Private Extension Methods
private extension PokemonListVC {
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func setTableViewAsRootView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func configureNavigationBarTitle() {
        navigationItem.title = "Pokedex"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func fetchPokemons() {
        self.startLoading()
        service.fetchPokemonList { [weak self] result in
            guard let self else { return }
            self.stopLoading()
            switch result {
            case .success(let pokemons):
                DispatchQueue.main.async {
                    self.pokemonList.append(contentsOf: pokemons)
                    self.pokemonCount = self.service.totalCount ?? 0
                    self.tableView.reloadData()
                }
            case .failure(let error):
                logger.error("An error occurred: \(error)")
            }
        }
    }

    func startLoading() {
        loadingView.show(in: view)
    }

    func stopLoading() {
        loadingView.hide()
    }
}

// MARK: - UITableViewDelegate Methods
extension PokemonListVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height - 20 {
            fetchPokemons()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let inSearchMode = inSearchMode(searchController)
        let selectedPokemon = inSearchMode ? filteredPokemonList[index] : pokemonList[index]
        let detailVc = PokemonDetailVC(pokemonId: selectedPokemon.id)
        navigationController?.pushViewController(detailVc, animated: true)
    }
}

// MARK: - UITableViewDataSource Methods
extension PokemonListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.inSearchMode(searchController)
        return inSearchMode ? filteredPokemonList.count : pokemonList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PokemonCell",
            for: indexPath
        ) as? PokemonTableViewCell else {
            logger.error("Failed to dequeue PokemonTableViewCell.")
            return UITableViewCell()
        }

        let inSearchMode = self.inSearchMode(searchController)
        let pokemon = inSearchMode ? filteredPokemonList[indexPath.row] : self.pokemonList[indexPath.row]
        cell.configure(pokemon)
        return cell
    }
}

// MARK: - Search Controller Methods
extension PokemonListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchableText = searchController.searchBar.text
        self.updateSearchController(text: searchableText)
    }

    func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }

    func updateSearchController(text: String?) {
        guard let searchText = text?.lowercased(), !searchText.isEmpty else {
            filteredPokemonList = []
            tableView.reloadData()
            return
        }

        filteredPokemonList = pokemonList.filter { pokemon in
            let matchesName = pokemon.name.lowercased().contains(searchText)
            let matchesId = String(pokemon.id).contains(searchText)
            return matchesName || matchesId
        }

        tableView.reloadData()
    }
}
