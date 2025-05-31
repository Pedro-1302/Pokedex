//
//  PokemonListVC.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

import UIKit

final class PokemonListVC: UIViewController {
    private let service: PokemonServiceProtocol

    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .red

        service.fetchPokemonList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    logger.debug("Pokemons: \(response.results)")
                case .failure(let error):
                    logger.error("An error occurred: \(error)")
                }
            }
        }
    }
}
