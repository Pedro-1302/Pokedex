//
//  PokemonService.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemonList(completion: @escaping (Result<PokemonListResponse, Error>) -> Void)
}

final class PokemonService: PokemonServiceProtocol {
    private let baseUrl: String = "https://pokeapi.co/api/v2/pokemon"
    private let limitPerPage: Int = 20

    func fetchPokemonList(completion: @escaping (Result<PokemonListResponse, Error>) -> Void) {
        let url = baseUrl + "?limit=\(limitPerPage)"

        guard let urlRequest = URL(string: url) else {
            logger.error("Error creating URL.")
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
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
                completion(.success(decoded))
            } catch {
                logger.error("Error parsing data. \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
