//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import Foundation

struct PokemonDetail: Codable {
    let height: Int
    let name: String
    let sprites: Sprites
    let stats: PokemonStatsResponse
    let types: PokemonTypeResponse
    let weight: Int
}

extension PokemonDetail {
    static func createMock() -> PokemonDetail {
        PokemonDetail(
            height: 15,
            name: "gengar",
            sprites: .createMock(),
            stats: .createMock(),
            types: .createMock(),
            weight: 405
        )
    }
}
