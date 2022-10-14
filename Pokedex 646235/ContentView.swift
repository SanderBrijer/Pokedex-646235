//
//  ContentView.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//
import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject var pokemonStore: PokemonStore
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    
    var body: some View {
        TabView{
            NavigationView {
                
                
                ScrollView {
                Text("All Pokémon’s")
                        .bold()                        .font(.system(size: 33))
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(pokemonStore.pokemons) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonCell(pokemon: pokemon)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .onAppear(perform: handleOnAppear)
                
                
            }
    
            .tabItem(){
                Image("pokebol")
                Text("Pokemon")
            }
            FavoritesView()
                .tabItem(){
                    Image(systemName: "heart")
                    Text("Favorites")
                }
        }
    }
}

// MARK: Action handlers
private extension ContentView {
    
    func handleOnAppear() {
        pokemonStore.loadData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
