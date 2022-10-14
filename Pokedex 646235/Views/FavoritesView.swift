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
    
    private let pokeAPI: PokeAPI = PokeAPI()

    var body: some View {
        if (favorites.ids.count != 0){
            Text("Favorite Pokemons")
                .bold()
            HStack{
                
                ForEach(favorites.ids, id: \.self) { favorite in
                    
//                    PokemonCell(pokemon: Pokemon(id: favorite, name: pokemonDetailed.name))
//                        .onAppear(perform: getPokemonDetails(pokemonId: favorite))

                    
                    
                    
                }
            }         
        }
        else{
            Text("You don't have any favorites!")
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
