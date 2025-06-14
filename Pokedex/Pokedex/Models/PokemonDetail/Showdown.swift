import Foundation

struct Showdown: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// swiftlint:disable line_length
extension Showdown {
    static func createMock() -> Showdown {
        Showdown(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/94.gif")
    }
}
// swiftlint:enable line_length
