import Foundation

struct PokemonHeaderInfo {
    let name: String
    let dexId: Int
    let imageURL: String
    let types: [PokemonTypeName]
}

// swiftlint: disable line_length
extension PokemonHeaderInfo {
    static func createMock() -> PokemonHeaderInfo {
        return PokemonHeaderInfo(name: "Gengar",
                                 dexId: 84,
                                 imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/84.png",
                                 types: [.ghost])
    }
}
// swiftlint: enable line_length
