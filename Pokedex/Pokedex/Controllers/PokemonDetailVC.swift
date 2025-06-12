//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import UIKit

final class PokemonDetailVC: UIViewController {
    private let service: PokemonServiceProtocol

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        view.backgroundColor = .red
        configureCardView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPokemon()
    }
}

extension PokemonDetailVC {
    private func configureCardView() {
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cardView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.6)
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
                    self?.pokemon = pokemonDetail
                    self?.navigationItem.title = pokemonDetail.name
                case .failure(let error):
                    logger.error("An error occurred: \(error)")
                }
            }
        }
    }
}
