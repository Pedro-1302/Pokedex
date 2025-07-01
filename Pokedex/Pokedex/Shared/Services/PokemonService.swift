import Foundation

protocol PokemonServiceProtocol {
    var totalCount: Int? { get }
    var limitPerPage: Int { get }
    func fetchPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> Void)
    func fetchPokemonDetail(pokemonId: Int, completion: @escaping (Result<PokemonDetailResponse, Error>) -> Void)
}

final class PokemonService: PokemonServiceProtocol {
    private let baseUrl: String = "https://pokeapi.co/api/v2/pokemon"
    private var nextPageUrl: String?
    private var isFetching: Bool = false

    private(set) var limitPerPage: Int = 20
    private(set) var totalCount: Int?

    func fetchPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        guard !isFetching else { return }
        isFetching = true

        let urlString = nextPageUrl ?? baseUrl + "?limit=\(limitPerPage)"

        guard let urlRequest = URL(string: urlString) else {
            logger.error("Error creating URL.")
            isFetching = false
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            defer { self.isFetching = false }

            if let error {
                completion(.failure(error))
                return
            }

            guard let data else {
                logger.error("Failed to get data. \(error)")
                completion(.failure(NSError(domain: "No data returned", code: 0)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                self.nextPageUrl = decoded.next
                if self.totalCount != nil { self.totalCount = decoded.count }
                let pokemons = decoded.results.map { $0.toPokemon() }
                completion(.success(pokemons))
            } catch {
                logger.error("Error parsing data. \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchPokemonDetail(
        pokemonId: Int,
        completion: @escaping (Result<PokemonDetailResponse, Error>) -> Void
    ) {
        let urlString = baseUrl + "/\(pokemonId)"

        guard let urlRequest = URL(string: urlString) else {
            logger.error("Error creating URL.")
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error {
                completion(.failure(error))
                return
            }

            guard let data else {
                logger.error("Failed to get data. \(error)")
                completion(.failure(NSError(domain: "No data returned", code: 0)))
                return
            }

            do {
                let dto = try JSONDecoder().decode(PokemonDetailDTO.self, from: data)
                let domainModel = dto.toDomain()
                completion(.success(domainModel))
            } catch {
                logger.error("Error parsing data. \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
