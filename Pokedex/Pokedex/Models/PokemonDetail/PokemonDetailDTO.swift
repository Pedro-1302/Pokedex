//
//  PokemonDetailDTO.swift
//  Pokedex
//
//  Created by Pedro Franco on 12/06/25.
//

import Foundation

struct PokemonDetailDTO: Codable {
    let height: Int
    let name: String
    let sprites: Sprites
    let types: [PokemonTypeSlot]
    let stats: [PokemonStatSlot]
    let weight: Int
}

extension PokemonDetailDTO {
    func toDomain() -> PokemonDetailResponse {
        return PokemonDetailResponse(
            height: height,
            name: name.capitalized,
            sprites: sprites,
            types: types,
            stats: stats,
            weight: weight
        )
    }
}
