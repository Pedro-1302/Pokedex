//
//  PokemonTypeSlot.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import Foundation

struct PokemonTypeSlot: Codable {
    let slot: Int
    let type: PokemonType
}

extension PokemonTypeSlot {
    static func createMock() -> PokemonTypeSlot {
        PokemonTypeSlot(slot: 1, type: .createMock())
    }
}
