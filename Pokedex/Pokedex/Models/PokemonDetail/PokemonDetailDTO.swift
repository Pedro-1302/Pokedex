import Foundation

struct PokemonDetailDTO: Codable {
    let id: Int
    let height: Int
    let name: String
    let sprites: Sprites
    let types: [PokemonTypeSlot]
    let stats: [PokemonStatSlot]
    let weight: Int
}

extension PokemonDetailDTO {
    func toDomain() -> PokemonDetailResponse {
        return PokemonDetailResponse(id: 84,
                                     height: height,
                                     name: name.capitalized,
                                     sprites: sprites,
                                     types: types,
                                     stats: stats,
                                     weight: weight)
    }
}
