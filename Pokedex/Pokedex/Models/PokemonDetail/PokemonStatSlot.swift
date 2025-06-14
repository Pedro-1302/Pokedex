import Foundation

struct PokemonStatSlot: Codable {
    let baseStat: Int
    let effort: Int
    let stat: PokemonStat

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

extension PokemonStatSlot {
    static func createMock() -> PokemonStatSlot {
        PokemonStatSlot(baseStat: 60,
                        effort: 0,
                        stat: .createMock())
    }
}
