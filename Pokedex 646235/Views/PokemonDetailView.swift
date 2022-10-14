//
//  PokemonDetailView.swift
//  Pokedex 646235
//
//  Created by user225611 on 10/13/22.
//
//
import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State var pokemonDetailed: PokemonDetailed?
    
    @State var isFavorite: Bool = false
    
    @EnvironmentObject var favorites: PokemonFavorites
    
    @State private var didAppear = false
    @State private var didCatch = false
    
    private let pokeAPI: PokeAPI = PokeAPI()
    
    @State var selected = 1
    
    var body: some View {
        if let pokemonDetailed = pokemonDetailed {
            Text("Got it")
        }
        else{
            Text("nope")
        }
        
        
        
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
        .frame(width: 300, height: 300)
        //            .resizable()
        //            .aspectRatio(contentMode: .fit)
        .navigationTitle(pokemon.name)
        .onAppear {
            didAppear = true
        }
        .scaleEffect(didAppear ? 1 : 2)
        .opacity(didAppear ? 1 : 0)
        .animation(.linear(duration: 0.5))
        //            .padding()
        .animation(
            .interpolatingSpring(
                stiffness: 10,
                damping: 1
            )
            .speed(3)
            .delay(1)
        )
        .transition(.opacity.combined(with: .slide))
        
        
        .onTapGesture {
            withAnimation {
                didCatch.toggle()
            }
        }
        
        
        if didCatch {
            Text("Pokemon is caught")
                .font(.headline)
                .transition(.opacity.combined(with: .slide))
        }
        
        Text("")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Stats") {
                        print("Stats")
                    };
                }
                
                ToolbarItem(placement: .navigationBarTrailing){
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
            }
        
        
        VStack {
            Picker(selection: $selected, label: Text("Picker"), content: {
                Text("About").tag(1)
                Text("Stats").tag(2)
                Text("Evolution").tag(3)
                
            })
            .pickerStyle(SegmentedPickerStyle())
            if pokemonDetailed != nil{
                
                if selected == 1 {
                    
                    var weatherDictionary: [String:String] = [
                        "Name": pokemonDetailed!.name,
                        "Id": String(pokemonDetailed!.id),
                        "Base": String(pokemonDetailed!.base_experience),
                        "Weight": String(pokemonDetailed!.weight),
                        "Height": String(pokemonDetailed!.height),
                        "Types": pokemonDetailed!.types.joined(separator: ", "),
                        "Abilities": pokemonDetailed!.abilities.joined(separator: ", "),
                    ]
                    
                    ForEach(weatherDictionary.sorted(by: <), id: \.key) { key, value in
                        
                        
                        HStack{
                            Text(key)
                                .bold()
                            Spacer()
                            Text(value)
                        }
                    }
                    
                } else if (selected == 2) {
                    List(0..<10) { item in
                        Text("item")
                    }
                }
                else{
                    
                }
            }
            
            
        }.padding(.horizontal, 20)
            .onAppear(perform: getPokemonDetails)
        
    }
    func getPokemonDetails(){
        pokeAPI.fetchPokemonDetailed(pokemonId: pokemon.id, completion: { result in
            switch result {
            case .success(let details): pokemonDetailed = details
            case .failure(let error): print(error)
            }
        })
    }
}
struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonDetailView(pokemon: Pokemon(id: 0, name: ""))
        }
    }
}
