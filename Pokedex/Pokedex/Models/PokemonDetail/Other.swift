import Foundation

struct Other: Codable {
    let showdown: Showdown
}

extension Other {
    static func createMock() -> Other {
        Other(showdown: .createMock())
    }
}
