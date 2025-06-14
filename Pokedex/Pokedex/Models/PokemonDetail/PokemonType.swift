import Foundation

struct PokemonType: Codable {
    let name: PokemonTypeName
    let url: String
}

extension PokemonType {
    static func createMock() -> PokemonType {
        PokemonType(name: .ghost,
                    url: "https://pokeapi.co/api/v2/type/8/")
    }
}
