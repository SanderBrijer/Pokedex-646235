//
//  Pokedex_646235App.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//

import SwiftUI

@main
struct Pokedex_646235App: App {
    
    @StateObject var pokemonStore = PokemonStore()
    @StateObject var favoritesStore = PokemonFavorites()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pokemonStore)
                .environmentObject(favoritesStore)
        }
    }
}
