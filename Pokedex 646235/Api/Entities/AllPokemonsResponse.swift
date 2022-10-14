//
//  AllPokemonsResponse.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//

import Foundation

struct AllPokemonsResponse: Decodable {
    
    let results: [PokemonEntity]
}

struct PokemonEntity: Decodable {
    
    let name: String
    let url: URL
}
