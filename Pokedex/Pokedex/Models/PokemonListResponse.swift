import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResponse]
}

extension PokemonListResponse {
    static func createMock() -> PokemonListResponse {
        PokemonListResponse(count: 1302,
                            next: "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20",
                            previous: nil,
                            results: [.createMock()])
    }
}
