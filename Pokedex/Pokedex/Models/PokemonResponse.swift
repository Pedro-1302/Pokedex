import Foundation

struct PokemonResponse: Codable {
    let name: String
    let url: String
}

// swiftlint:disable line_length
extension PokemonResponse {
    func toPokemon() -> Pokemon {
        let id: Int = url.getPokemonId() ?? 0
        let imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        let name = name.capitalized
        return Pokemon(
            id: id,
            name: name,
            imageUrl: imageUrl,
            url: url
        )
    }
}
// swiftlint:enable line_length

extension PokemonResponse {
    static func createMock() -> PokemonResponse {
        PokemonResponse(name: "gengar",
                        url: "https://pokeapi.co/api/v2/pokemon/84")
    }
}
