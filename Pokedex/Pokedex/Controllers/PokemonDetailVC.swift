//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import UIKit

class PokemonDetailVC: UIViewController {

    let pokemonId: Int

    init(pokemonId: Int) {
        self.pokemonId = pokemonId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }

}
