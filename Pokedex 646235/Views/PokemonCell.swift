//
//  PokemonCell.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//

import SwiftUI

struct PokemonCell: View {
    
    @State var isFavorite: Bool = false
    
    @EnvironmentObject var favorites: PokemonFavorites
    
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            HStack(){
                Text(String(format: "%03d", pokemon.id))
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .foregroundColor(.white)
                    .background(Color(red: 86/255, green: 49/255, blue: 232/255))
                    .font(.system(size: 10))
                    .frame(alignment: .topLeading)
                    .cornerRadius(20)
                Spacer()
            }
            .padding(.top, 10)
            .padding(.leading, 15)
            .frame(alignment: .topLeading)
            
            
            HStack {
                AsyncImage(
                    url: pokemon.imageUrl,
                    content: { image in
                        image
                            .resizable()
                    },
                    placeholder: {
                        Color.red
                    }
                )
                .frame(width: 100, height: 100)
                
            }
            
            HStack {
                Text(pokemon.name.capitalized)
                    .foregroundColor(.black)
                Spacer()
                let favorite = favorites.ids.contains(pokemon.id)
                Button(
                    action: {
                        favorites.toggleFav(id: pokemon.id)
                    },
                    label: {
                        let favorite = favorites.ids.contains(pokemon.id)
                        
                        Image(systemName: favorite ? "heart.fill" : "heart")
                    }
                )
                
                
                
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 5)
            .background(.white)
        }
        .frame( maxWidth: 400)
        .background(Color(red: 246/255, green: 246/255, blue: 255/255))
    }
}

struct PokemonCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell(pokemon: Pokemon(id: 1, name: "bulbasaur"))
    }
}
