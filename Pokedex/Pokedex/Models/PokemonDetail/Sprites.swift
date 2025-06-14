import Foundation

struct Sprites: Codable {
    let other: Other

    enum CodingKeys: String, CodingKey {
        case other
    }
}

extension Sprites {
    static func createMock() -> Sprites {
        Sprites(other: .createMock())
    }
}
