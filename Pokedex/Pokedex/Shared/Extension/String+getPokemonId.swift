import Foundation

extension String {
    func getPokemonId() -> Int? {
        let components = self.split(separator: "/").map { String($0) }
        if let lastComponent = components.last, let id = Int(lastComponent) {
            return id
        }
        return nil
    }
}
