//
//  PokemonDetailResponse.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import Foundation

struct PokemonDetailResponse: Codable {
    let height: Int
    let name: String
    let sprites: Sprites
    let types: [PokemonTypeSlot]
    let stats: [PokemonStatSlot]
    let weight: Int
}

extension PokemonDetailResponse {
    static func createMock() -> PokemonDetailResponse {
        PokemonDetailResponse(
            height: 15,
            name: "gengar",
            sprites: .createMock(),
            types: [.createMock()],
            stats: [.createMock()],
            weight: 405
        )
    }
}
