//
//  PokeAPI.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//

import Foundation
import Combine


class PokeAPI {
    
    // MARK: Properties
    private var cancellables: [AnyCancellable] = []
    
    // MARK: Methods
    func fetchAllPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon")!
        fetch(type: AllPokemonsResponse.self, url: url, completion: { result in
            switch result {
            case .success(let response):
                let pokemons = response.results
                    .enumerated()
                    .map({ (i, entity) in
                        return Pokemon(id: Int(entity.url.lastPathComponent)!, name: entity.name)
                    })
                completion(.success(pokemons))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: Methods
    func fetchPokemonDetailed(pokemonId: Int, completion: @escaping (Result<PokemonDetailed, Error>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonId)/")!
        fetch(type: PokemonDetailedEntity.self, url: url, completion: { result in
            switch result {
            case .success(let entity):
                let pokemonDetailed = PokemonDetailed(
                    id: entity.id,
                    name: entity.name,
                    base_experience: entity.base_experience,
                    weight: entity.weight,
                    height: entity.height,
                    types: entity.types.map({ typesEntity in
                        return typesEntity.type.name
                    }),
                    abilities: entity.abilities.map({ typesEntity in
                        return typesEntity.ability.name
                    })
                )
                completion(.success(pokemonDetailed))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

// MARK: Helpers
private extension PokeAPI {
    
    func fetch<T: Decodable>(type: T.Type, url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        completion(.failure(error))
                    }
                },
                receiveValue: { response in
                    completion(.success(response))
                }
            )
            .store(in: &cancellables)
    }
}
