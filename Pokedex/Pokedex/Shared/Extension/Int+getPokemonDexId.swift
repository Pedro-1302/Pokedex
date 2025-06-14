import Foundation

extension Int {
    func getPokemonDexId() -> String {
        String(format: "#%03d", self)
    }
}
