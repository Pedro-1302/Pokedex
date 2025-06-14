import Foundation

// swiftlint:disable identifier_name
enum PokemonStatType: String, Codable, CaseIterable {
    case hp = "hp"
    case attack = "attack"
    case defense = "defense"
    case specialAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed = "speed"
}
// swiftlint:enable identifier_name
