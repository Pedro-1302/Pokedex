//
//  Int+getPokemonDexId.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

import Foundation

extension Int {
    func getPokemonDexId() -> String {
        return String(format: "#%03d", self)
    }
}
