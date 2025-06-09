//
//  PokemonStatsResponse.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import Foundation

struct PokemonStatsResponse: Codable {
    let stats: [PokemonStatSlot]
}

extension PokemonStatsResponse {
    static func createMock() -> PokemonStatsResponse {
        PokemonStatsResponse(stats: [.createMock()])
    }
}
