//
//  Pokemon.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//
import Foundation

struct Pokemon: Identifiable {
    
    let id: Int
    let name: String
    
    var imageUrl: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}
