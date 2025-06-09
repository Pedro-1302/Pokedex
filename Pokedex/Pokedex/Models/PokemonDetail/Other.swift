//
//  Other.swift
//  Pokedex
//
//  Created by Pedro Franco on 09/06/25.
//

import Foundation

struct Other: Codable {
    let showdown: Showdown
}

extension Other {
    static func createMock() -> Other {
        Other(showdown: .createMock())
    }
}
