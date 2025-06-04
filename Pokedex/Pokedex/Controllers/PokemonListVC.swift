//
//  PokemonListVC.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

import UIKit

final class PokemonListVC: UIViewController {
    private let service: PokemonServiceProtocol
    private var pokemonList: [Pokemon] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        return tableView
    }()

    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitle()
        view = tableView

    }

    private func fetchPokemons() {
        service.fetchPokemonList { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let pokemons):
                DispatchQueue.main.async {
                    self.pokemonList.append(contentsOf: pokemons)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                logger.error("An error occurred: \(error)")
            }
        }
    }
}

extension PokemonListVC {
    private func configureNavigationBarTitle() {
        navigationItem.title = "Pokedex"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension PokemonListVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height - 20 {
            fetchPokemons()
        }
    }
}

extension PokemonListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PokemonCell",
            for: indexPath
        ) as? PokemonTableViewCell else {
            logger.error("Failed to dequeue PokemonTableViewCell.")
            return UITableViewCell()
        }

        let pokemon = pokemonList[indexPath.row]
        cell.configure(pokemon)
        return cell
    }
}
