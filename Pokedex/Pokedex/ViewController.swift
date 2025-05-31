//
//  ViewController.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

import UIKit

struct PokemonListResponse: Codable {
    let count: Int
    let next: String
    let previous: String
    let results: [PokemonResponse]
}

struct PokemonResponse: Codable {
    let name: String
    let url: String
}

protocol PokemonServiceProtocol {
    func fetchPokemonList()
}

final class PokemonService: PokemonServiceProtocol {
    private let baseUrl: String = "https://pokeapi.co/api/v2/pokemon"
    private let limitPerPage: Int = 20

    func fetchPokemonList() {
        let url = baseUrl + "?limit=\(limitPerPage)"
    }
}

final class ViewController: UIViewController {
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
    }
}
