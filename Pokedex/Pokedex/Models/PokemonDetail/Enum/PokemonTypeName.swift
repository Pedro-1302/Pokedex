import UIKit

enum PokemonTypeName: String, Codable {
    case normal
    case fire
    case fairy
    case steel
    case dark
    case dragon
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost

    var displayName: String {
        rawValue.capitalized
    }

    var color: UIColor {
        return switch self {
        case .normal:
            UIColor(hex: "#A8A77A")
        case .fire:
            UIColor(hex: "#EE8130")
        case .fairy:
            UIColor(hex: "#D685AD")
        case .steel:
            UIColor(hex: "#B7B7CE")
        case .dark:
            UIColor(hex: "#705746")
        case .dragon:
            UIColor(hex: "#6F35FC")
        case .water:
            UIColor(hex: "#6390F0")
        case .electric:
            UIColor(hex: "#F7D02C")
        case .grass:
            UIColor(hex: "#7AC74C")
        case .ice:
            UIColor(hex: "#96D9D6")
        case .fighting:
            UIColor(hex: "#C22E28")
        case .poison:
            UIColor(hex: "#A33EA1")
        case .ground:
            UIColor(hex: "#E2BF65")
        case .flying:
            UIColor(hex: "#A98FF3")
        case .psychic:
            UIColor(hex: "#F95587")
        case .bug:
            UIColor(hex: "#A6B91A")
        case .rock:
            UIColor(hex: "#B6A136")
        case .ghost:
            UIColor(hex: "#735797")
        }
    }
}
