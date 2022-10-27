//
//  FavoritesView.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//


import SwiftUI


struct FavoritesView: View {
    @EnvironmentObject var favorites: PokemonFavorites
    @State var pokemonDetailed: PokemonDetailed?
    @EnvironmentObject var pokemonStore: PokemonStore
    
    private let pokeAPI: PokeAPI = PokeAPI()
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            if (!favorites.ids.isEmpty){
                
                NavigationView {
                    
                    
                    ScrollView {
                        Text("Favorite Pokémon’s")
                            .bold()                        .font(.system(size: 33))
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            var pokemons = pokemonStore.pokemons
                            
                            ForEach(pokemons.filter({ favorites.ids.contains($0.id) })) { favoritePokemon in
                                var pokemon = Pokemon(id: favoritePokemon.id, name: favoritePokemon.name)
                                
                                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                    PokemonCell(pokemon: pokemon)
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                Spacer()
                
            }
            
            else{
                Text("You don't have any favorites!")
            }
            
      
        }
    }
    
    
    func getPokemonDetails(pokemonId: Int){
        pokeAPI.fetchPokemonDetailed(pokemonId: pokemonId, completion: { result in
            switch result {
            case .success(let details): pokemonDetailed = details
            case .failure(let error): print(error)
            }
        })
    }
}
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
