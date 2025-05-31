//
//  String+getPokemonId.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

import Foundation

extension String {
    func getPokemonId() -> Int? {
        let components = self.split(separator: "/").map { String($0) }
        if let lastComponent = components.last, let id = Int(lastComponent) {
            return id
        }
        return nil
    }
}
