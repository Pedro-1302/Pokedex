//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import UIKit

final class PokemonDetailVC: UIViewController {
    private let service: PokemonServiceProtocol

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
        fetchPokemon()
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
