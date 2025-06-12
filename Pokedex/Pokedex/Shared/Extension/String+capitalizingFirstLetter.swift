//
//  String+capitalizingFirstLetter.swift
//  Pokedex
//
//  Created by Pedro Franco on 12/06/25.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
}
