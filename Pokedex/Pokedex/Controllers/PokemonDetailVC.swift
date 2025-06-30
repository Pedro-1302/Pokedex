import UIKit

final class PokemonDetailVC: UIViewController {
    private let service: PokemonServiceProtocol
    private let headerView = PokemonHeaderView()

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let blurBackgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()

    private let pokemonStatsLabel: UILabel = {
        let label = UILabel()
        label.text = "Base Stats"
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let hpStatView = PokemonStatView(title: "HP", maxValue: "255")
    private let attackStatView = PokemonStatView(title: "Attack", maxValue: "181")
    private let defenseStatView = PokemonStatView(title: "Defense", maxValue: "230")
    private let specialAttackStatView = PokemonStatView(title: "Special Attack", maxValue: "180")
    private let specialDefenseStatView = PokemonStatView(title: "Special Defense", maxValue: "230")
    private let speedStatView = PokemonStatView(title: "Speed", maxValue: "200")

    let pokemonId: Int

    private var pokemon: PokemonDetailResponse = .createMock()

    init(
        pokemonId: Int,
        service: PokemonServiceProtocol = PokemonService()
    ) {
        self.pokemonId = pokemonId
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarStyle(displayMode: .never, prefersLargeTitles: false)
        configureBlur()
        configureHeaderStackView()
        configureCardView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPokemon()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNavigationBarStyle(displayMode: .always, prefersLargeTitles: true)
    }
}

// MARK: - Private Extension Methods
private extension PokemonDetailVC {
    func setNavigationBarStyle(displayMode: UINavigationItem.LargeTitleDisplayMode, prefersLargeTitles: Bool) {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    func configureBlur() {
        view.addSubview(blurBackgroundView)
        NSLayoutConstraint.activate([
            blurBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            blurBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func configureHeaderStackView() {
        view.addSubview(headerView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.2)
        ])
    }

    func configureCardView() {
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        configurePokemonStatsLabel()
        configureHpStatView()
        configureAttackStatView()
        configureDefenseStatView()
        configureSpecialAttackStatView()
        configureSpecialDefenseStatView()
        configureSpeedStatView()
    }

    func configurePokemonStatsLabel() {
        cardView.addSubview(pokemonStatsLabel)
        NSLayoutConstraint.activate([
            pokemonStatsLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 32),
            pokemonStatsLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            pokemonStatsLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    func configureHpStatView() {
        cardView.addSubview(hpStatView)
        NSLayoutConstraint.activate([
            hpStatView.topAnchor.constraint(equalTo: pokemonStatsLabel.bottomAnchor, constant: 16),
            hpStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            hpStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    func configureAttackStatView() {
        cardView.addSubview(attackStatView)
        NSLayoutConstraint.activate([
            attackStatView.topAnchor.constraint(equalTo: hpStatView.bottomAnchor, constant: 16),
            attackStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            attackStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    func configureDefenseStatView() {
        cardView.addSubview(defenseStatView)
        NSLayoutConstraint.activate([
            defenseStatView.topAnchor.constraint(equalTo: attackStatView.bottomAnchor, constant: 16),
            defenseStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            defenseStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    func configureSpecialAttackStatView() {
        cardView.addSubview(specialAttackStatView)
        NSLayoutConstraint.activate([
            specialAttackStatView.topAnchor.constraint(equalTo: defenseStatView.bottomAnchor, constant: 16),
            specialAttackStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            specialAttackStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    func configureSpecialDefenseStatView() {
        cardView.addSubview(specialDefenseStatView)
        NSLayoutConstraint.activate([
            specialDefenseStatView.topAnchor.constraint(equalTo: specialAttackStatView.bottomAnchor, constant: 16),
            specialDefenseStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            specialDefenseStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    func configureSpeedStatView() {
        cardView.addSubview(speedStatView)
        NSLayoutConstraint.activate([
            speedStatView.topAnchor.constraint(equalTo: specialDefenseStatView.bottomAnchor, constant: 16),
            speedStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            speedStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    func fetchPokemon() {
        service.fetchPokemonDetail(pokemonId: pokemonId) { [weak self] result in
            switch result {
            case .success(let pokemonDetail):
                self?.setupViews(pokemonDetail)
            case .failure(let error):
                logger.error("An error occurred: \(error)")
            }
        }
    }

    func setupViews(_ pokemonDetail: PokemonDetailResponse) {
        DispatchQueue.main.async { [weak self] in
            let id = pokemonDetail.id
            let types = pokemonDetail.types.compactMap { $0.type.name }
            let name = pokemonDetail.name
            let url = pokemonDetail.sprites.other.showdown.frontDefault
            let color = pokemonDetail.types.map { $0.type.name.color }.first
            self?.view.backgroundColor = color
            self?.pokemon = pokemonDetail
            self?.navigationItem.title = name
            let headerInfo = PokemonHeaderInfo(name: name,
                                               dexId: id,
                                               imageURL: url,
                                               types: types)
            self?.headerView.configure(with: headerInfo)
            self?.pokemonStatsLabel.textColor = color
            for stat in pokemonDetail.stats {
                switch stat.stat.name {
                case .hp:
                    self?.hpStatView.updateStat(
                        baseValue: stat.baseStat,
                        maxValue: 255,
                        color: color
                    )
                case .attack:
                    self?.attackStatView.updateStat(
                        baseValue: stat.baseStat,
                        maxValue: 181,
                        color: color
                    )
                case .defense:
                    self?.defenseStatView.updateStat(
                        baseValue: stat.baseStat,
                        maxValue: 230,
                        color: color
                    )
                case .specialAttack:
                    self?.specialAttackStatView.updateStat(
                        baseValue: stat.baseStat,
                        maxValue: 180,
                        color: color
                    )
                case .specialDefense:
                    self?.specialDefenseStatView.updateStat(
                        baseValue: stat.baseStat,
                        maxValue: 230,
                        color: color
                    )
                case .speed:
                    self?.speedStatView.updateStat(
                        baseValue: stat.baseStat,
                        maxValue: 200,
                        color: color
                    )
                }
            }
        }
    }
}
