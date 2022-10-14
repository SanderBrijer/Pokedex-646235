//
//  PokemonDetailedResponse.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//

import Foundation

struct PokemonDetailedEntity: Decodable {
    
    let id: Int
    let name: String
    let base_experience: Int
    
    let weight: Int
    let height: Int
    let types: [TypesResponse]
    let abilities: [AbilitiesResponse]
}

struct TypesResponse: Decodable {
    
    let slot: Int
    let type: TypeEntity
}

struct TypeEntity: Decodable {
    
    let name: String
    let url: URL
}

struct AbilitiesResponse: Decodable {
    
    let ability: AbilityEntity
    let is_hidden: Bool
    let slot: Int
}

struct AbilityEntity: Decodable {
    
    let name: String
    let url: URL
}


