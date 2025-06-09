//
//  PokemonService.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> Void)
    func fetchPokemonDetail(pokemonId: Int,
                            completion: @escaping (Result<Pokemon, Error>) -> Void)
}

final class PokemonService: PokemonServiceProtocol {
    private let baseUrl: String = "https://pokeapi.co/api/v2/pokemon"
    private let limitPerPage: Int = 20
    private var nextPageUrl: String?
    private var isFetching: Bool = false

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
                let pokemons = decoded.results.map { $0.toPokemon() }
                completion(.success(pokemons))
            } catch {
                logger.error("Error parsing data. \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchPokemonDetail(pokemonId: Int,
                            completion: @escaping (Result<Pokemon, any Error>) -> Void) {
        let urlString = baseUrl + "\(pokemonId)"

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
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                logger.error("Error parsing data. \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
