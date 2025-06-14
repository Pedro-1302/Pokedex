//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import UIKit

final class PokemonDetailVC: UIViewController {
    private let service: PokemonServiceProtocol

    private let headerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 16
        view.alignment = .center
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return view
    }()

    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let infoStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 4
        return view
    }()

    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dexIdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let pokemonTypesStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = 8
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

    init(pokemonId: Int, service: PokemonServiceProtocol = PokemonService()) {
        self.pokemonId = pokemonId
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureBlur()
        configureHeaderStackView()
        configurePokemonImageView()
        configureInfoStackView()
        configureCardView()
        configureDexIdLabel()
        configurePokemonLabelName()
        configurePokemonTypeStackView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPokemon()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension PokemonDetailVC {
    private func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func configureBlur() {
        view.addSubview(blurBackgroundView)
        NSLayoutConstraint.activate([
            blurBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            blurBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureHeaderStackView() {
        view.addSubview(headerStackView)
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.2)
        ])
    }

    private func configureInfoStackView() {
        headerStackView.addArrangedSubview(infoStackView)
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.2)
        ])
    }

    private func configurePokemonImageView() {
        headerStackView.addArrangedSubview(pokemonImageView)
        NSLayoutConstraint.activate([
            pokemonImageView.widthAnchor.constraint(equalToConstant: 96),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 96)
        ])
    }

    private func configureCardView() {
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 16),
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

    private func configurePokemonStatsLabel() {
        cardView.addSubview(pokemonStatsLabel)
        NSLayoutConstraint.activate([
            pokemonStatsLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 32),
            pokemonStatsLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            pokemonStatsLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    private func configureHpStatView() {
        cardView.addSubview(hpStatView)
        NSLayoutConstraint.activate([
            hpStatView.topAnchor.constraint(equalTo: pokemonStatsLabel.bottomAnchor, constant: 16),
            hpStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            hpStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    private func configureAttackStatView() {
        cardView.addSubview(attackStatView)
        NSLayoutConstraint.activate([
            attackStatView.topAnchor.constraint(equalTo: hpStatView.bottomAnchor, constant: 16),
            attackStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            attackStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    private func configureDefenseStatView() {
        cardView.addSubview(defenseStatView)
        NSLayoutConstraint.activate([
            defenseStatView.topAnchor.constraint(equalTo: attackStatView.bottomAnchor, constant: 16),
            defenseStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            defenseStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    private func configureSpecialAttackStatView() {
        cardView.addSubview(specialAttackStatView)
        NSLayoutConstraint.activate([
            specialAttackStatView.topAnchor.constraint(equalTo: defenseStatView.bottomAnchor, constant: 16),
            specialAttackStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            specialAttackStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    private func configureSpecialDefenseStatView() {
        cardView.addSubview(specialDefenseStatView)
        NSLayoutConstraint.activate([
            specialDefenseStatView.topAnchor.constraint(equalTo: specialAttackStatView.bottomAnchor, constant: 16),
            specialDefenseStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            specialDefenseStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    private func configureSpeedStatView() {
        cardView.addSubview(speedStatView)
        NSLayoutConstraint.activate([
            speedStatView.topAnchor.constraint(equalTo: specialDefenseStatView.bottomAnchor, constant: 16),
            speedStatView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 32),
            speedStatView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -32)
        ])
    }

    private func configureDexIdLabel() {
        infoStackView.addArrangedSubview(dexIdLabel)
    }

    private func configurePokemonLabelName() {
        infoStackView.addArrangedSubview(pokemonNameLabel)
    }

    private func configurePokemonTypeStackView() {
        infoStackView.addArrangedSubview(pokemonTypesStackView)
    }

    private func fetchPokemon() {
        service.fetchPokemonDetail(pokemonId: pokemonId) { [weak self] result in
            switch result {
            case .success(let pokemonDetail):
                self?.setupViews(pokemonDetail)
            case .failure(let error):
                logger.error("An error occurred: \(error)")
            }
        }
    }

    private func setupViews(_ pokemonDetail: PokemonDetailResponse) {
        DispatchQueue.main.async { [weak self] in
            let id = pokemonDetail.id
            let types = pokemonDetail.types.compactMap { $0.type.name }
            let name = pokemonDetail.name
            let url = pokemonDetail.sprites.other.showdown.frontDefault
            let color = pokemonDetail.types.map { $0.type.name.color }.first
            self?.view.backgroundColor = color
            self?.pokemon = pokemonDetail
            self?.navigationItem.title = name
            self?.pokemonNameLabel.text = name
            self?.dexIdLabel.text = id.getPokemonDexId()
            self?.pokemonImageView.setImage(from: url)
            self?.showPokemonTypes(types)
            self?.pokemonStatsLabel.textColor = color

            for stat in pokemonDetail.stats {
                switch stat.stat.name {
                case "hp":
                    self?.hpStatView.updateStat(baseValue: stat.baseStat,
                                                maxValue: 255,
                                                color: color)
                case "attack":
                    self?.attackStatView.updateStat(baseValue: stat.baseStat,
                                                    maxValue: 181,
                                                    color: color)
                case "defense":
                    self?.defenseStatView.updateStat(baseValue: stat.baseStat,
                                                     maxValue: 230,
                                                     color: color)
                case "special-attack":
                    self?.specialAttackStatView.updateStat(baseValue: stat.baseStat,
                                                           maxValue: 180,
                                                           color: color)
                case "special-defense":
                    self?.specialDefenseStatView.updateStat(baseValue: stat.baseStat,
                                                            maxValue: 230,
                                                            color: color)
                case "speed":
                    self?.speedStatView.updateStat(baseValue: stat.baseStat,
                                                   maxValue: 200,
                                                   color: color)
                default:
                    break
                }
            }
        }
    }

    private func showPokemonTypes(_ types: [PokemonTypeName]) {
        pokemonTypesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.alignment = .leading
        verticalStack.distribution = .fill
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        pokemonTypesStackView.addArrangedSubview(verticalStack)
        let maxWidth = view.bounds.width - 32
        var currentLineStack = createNewLineStackView()
        verticalStack.addArrangedSubview(currentLineStack)
        var currentLineWidth: CGFloat = 0
        for type in types {
            let typeView = UIView()
            typeView.backgroundColor = type.color
            typeView.layer.cornerRadius = 4
            typeView.translatesAutoresizingMaskIntoConstraints = false

            let label = UILabel()
            label.text = type.displayName
            label.textColor = .white
            label.font = .systemFont(ofSize: 14, weight: .bold)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false

            typeView.addSubview(label)
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: typeView.topAnchor, constant: 4),
                label.bottomAnchor.constraint(equalTo: typeView.bottomAnchor, constant: -4),
                label.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 8),
                label.trailingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: -8)
            ])

            let labelSize = label.intrinsicContentSize
            let typeViewWidth = labelSize.width + 16
            if currentLineWidth + typeViewWidth + (currentLineWidth > 0 ? 8 : 0) > maxWidth {
                currentLineStack = createNewLineStackView()
                verticalStack.addArrangedSubview(currentLineStack)
                currentLineWidth = 0
            }

            currentLineStack.addArrangedSubview(typeView)
            typeView.widthAnchor.constraint(equalToConstant: typeViewWidth).isActive = true
            currentLineWidth += typeViewWidth + (currentLineWidth > 0 ? 8 : 0)
        }
    }

    private func createNewLineStackView() -> UIStackView {
        let lineStack = UIStackView()
        lineStack.axis = .horizontal
        lineStack.spacing = 8
        lineStack.alignment = .center
        lineStack.distribution = .fillProportionally
        return lineStack
    }
}
