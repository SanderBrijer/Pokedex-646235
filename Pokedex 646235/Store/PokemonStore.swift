//
//  PokemonStore.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//
import Foundation

class PokemonStore: ObservableObject {
    
    @Published var pokemons: [Pokemon] = []
     
    private let pokeAPI: PokeAPI = PokeAPI()
    
    func loadData() {
        pokeAPI.fetchAllPokemons(completion: { result in
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }

}
