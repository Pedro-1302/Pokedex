//
//  PokemonStat.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import Foundation

struct PokemonStat: Codable {
    let name: String
    let url: String
}

extension PokemonStat {
    static func createMock() -> PokemonStat {
        PokemonStat(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
    }
}
