import Foundation

struct PokemonTypeSlot: Codable {
    let slot: Int
    let type: PokemonType
}

extension PokemonTypeSlot {
    static func createMock() -> PokemonTypeSlot {
        PokemonTypeSlot(slot: 1,
                        type: .createMock())
    }
}
