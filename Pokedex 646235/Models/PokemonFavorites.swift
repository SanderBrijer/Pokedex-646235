//
//  PokemonFavorites.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//


import Foundation
import Combine
import SwiftUI

class PokemonFavorites: ObservableObject {
    @Published var ids: [Int] = []
    
    
    func toggleFav(id: Int){
        if let index = ids.firstIndex(of: id) {
          ids.remove(at: index)
        }
        else{
            ids.insert(id, at: 0)
        }
    }
}
