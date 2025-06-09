//
//  PokemonTypeResponse.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import Foundation

struct PokemonTypeResponse: Codable {
    let types: [PokemonTypeSlot]
}

extension PokemonTypeResponse {
    static func createMock() -> PokemonTypeResponse {
        PokemonTypeResponse(types: [.createMock()])
    }
}
