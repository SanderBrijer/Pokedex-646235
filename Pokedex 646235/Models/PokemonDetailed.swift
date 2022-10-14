//
//  PokemonDetailed.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//

import Foundation

struct PokemonDetailed: Identifiable {
    
    let id: Int
    let name: String
    let base_experience: Int

    let weight: Int
    let height: Int
    let types: [String]
    let abilities: [String]
    
    
    var imageUrl: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}
