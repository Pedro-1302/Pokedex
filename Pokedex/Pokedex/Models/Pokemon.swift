//
//  Pokemon.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

struct Pokemon {
    let id: Int
    let name: String
    let imageUrl: String
    let url: String
}

extension Pokemon {
    static func getMock() -> Pokemon {
        let id = 94
        return Pokemon(
            id: id,
            name: "Gengar",
            imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png",
            url: "https://pokeapi.co/api/v2/pokemon/\(id)"
        )
    }
}
