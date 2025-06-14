import Foundation

struct PokemonStat: Codable {
    let name: PokemonStatType
    let url: String
}

extension PokemonStat {
    static func createMock() -> PokemonStat {
        PokemonStat(name: .hp,
                    url: "https://pokeapi.co/api/v2/stat/1/")
    }
}
