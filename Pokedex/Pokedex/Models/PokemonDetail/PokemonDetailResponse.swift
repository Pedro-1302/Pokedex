//
//  PokemonDetailResponse.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import UIKit

struct PokemonDetailResponse: Codable {
    let id: Int
    let height: Int
    let name: String
    let sprites: Sprites
    let types: [PokemonTypeSlot]
    let stats: [PokemonStatSlot]
    let weight: Int

    var typeNames: [String] {
        types.map { $0.type.name.displayName }
    }

    var typeColors: [UIColor] {
        types.map { $0.type.name.color }
    }
}

extension PokemonDetailResponse {
    static func createMock() -> PokemonDetailResponse {
        PokemonDetailResponse(
            id: 84,
            height: 15,
            name: "gengar",
            sprites: .createMock(),
            types: [.createMock()],
            stats: [.createMock()],
            weight: 405
        )
    }
}
