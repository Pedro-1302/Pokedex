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

    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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

    let pokemonId: Int

    private var pokemon: PokemonDetailResponse = .createMock()

    init(pokemonId: Int,
         service: PokemonServiceProtocol = PokemonService()) {
        self.pokemonId = pokemonId
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureHeaderStackView()
        configurePokemonImageView()
        configureInfoStackView()
        configureCardView()
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
    }

    private func showLoading() {
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configurePokemonLabelName() {
        infoStackView.addArrangedSubview(pokemonNameLabel)
    }

    private func configurePokemonTypeStackView() {
        infoStackView.addArrangedSubview(pokemonTypesStackView)
    }

    private func hideLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 0
        }, completion: { _ in
            self.loadingView.removeFromSuperview()
        })
    }

    private func fetchPokemon() {
        showLoading()
        service.fetchPokemonDetail(pokemonId: pokemonId) { result in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoading()
                switch result {
                case .success(let pokemonDetail):
                    let types = pokemonDetail.types.compactMap { $0.type.name }
                    let name = pokemonDetail.name
                    let url = pokemonDetail.sprites.other.showdown.frontDefault
                    let color = pokemonDetail.types.map { $0.type.name.color }.first
                    self?.pokemon = pokemonDetail
                    self?.navigationItem.title = name
                    self?.pokemonNameLabel.text = name
                    self?.view.backgroundColor = color
                    self?.loadImage(from: url)
                    self?.showPokemonTypes(types)
                case .failure(let error):
                    logger.error("An error occurred: \(error)")
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

    private func loadImage(from urlString: String) {
        if let url = URL(string: urlString) {
            let shimmer = ShimmerView(frame: pokemonImageView.bounds)
            pokemonImageView.kf.setImage(
                with: url,
                placeholder: shimmer,
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ],
                completionHandler: { result in
                    shimmer.stopShimmer()
                    switch result {
                    case .success(let value):
                        logger.debug("Image loaded: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        logger.error("Failed to load image: \(error)")
                    }
                }
            )
        } else {
            logger.error("Error loading image URL. Attempt to use placeholder image.")
            pokemonImageView.image = UIImage(named: "placeholder")
        }
    }
}
