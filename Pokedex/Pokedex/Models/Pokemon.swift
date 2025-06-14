import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let imageUrl: String
    let url: String
}

// swiftlint:disable line_length
extension Pokemon {
    static func getMock() -> Pokemon {
        let id = 94
        return Pokemon(
            id: id,
            name: "Gengar",
            imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png",
            url: "https://pokeapi.co/api/v2/pokemon/\(id)"
        )
    }
}
// swiftlint:enable line_length
