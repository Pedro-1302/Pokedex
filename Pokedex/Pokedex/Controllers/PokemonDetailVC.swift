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

    let pokemonId: Int

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
        self.view.backgroundColor = .red
        configureCardView()
        fetchPokemon()
    }

    private func configureCardView() {
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cardView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.6)
        ])
    }
}

extension PokemonDetailVC {
    private func fetchPokemon() {
        service.fetchPokemonDetail(pokemonId: pokemonId) { result in
            switch result {
            case .success(let pokemonDetail):
                print("Pokemon Detail: \(pokemonDetail)")
            case .failure(let error):
                logger.error("An error occurred: \(error)")
            }
        }
    }
}
