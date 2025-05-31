//
//  PokemonListResponse.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResponse]
}
