//
//  PokemonType.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import Foundation

struct PokemonType: Codable {
    let name: PokemonTypeName
    let url: String
}

extension PokemonType {
    static func createMock() -> PokemonType {
        PokemonType(name: .ghost, url: "https://pokeapi.co/api/v2/type/8/")
    }
}
