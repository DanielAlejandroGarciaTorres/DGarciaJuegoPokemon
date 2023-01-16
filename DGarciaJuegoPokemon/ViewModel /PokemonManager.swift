//
//  PokemonManager.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 16/01/23.
//

import Foundation

struct PokemonManager {
    let pokemonURL : String = "https://pokeapi.co/api/v2/pokemon?limit=829"
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data {
                    if let pokemon = self.parseJSON(pokemonData: safeData){
                        print(pokemon)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(pokemonData: Data) -> [PokemonModel]? {
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemon = decodeData.results?.map {
                PokemonModel(named: $0.name , imageUrl: $0.url )
            }
            return pokemon
        } catch {
            return nil
        }
    }
}
