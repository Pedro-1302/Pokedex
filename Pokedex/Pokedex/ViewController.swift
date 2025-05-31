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

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .red
    }

}
