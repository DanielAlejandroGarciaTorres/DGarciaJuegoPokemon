//
//  PokemonManager.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 16/01/23.
//

import Foundation

struct PokemonManager {
    //    let pokemonURL : String = "https://pokeapi.co/api/v2/pokemon?limit=829"
    
    func fetchPokemon(pokemonCompletionHandler : @escaping (Result) -> Void) {
        var result = Result()
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=829") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    result.Correct = false
                    result.ErrorMessage = error!.localizedDescription
                    result.Ex = error
                }
                
                if let safeData = data {
                    if let pokemon = self.parseJSON(pokemonData: safeData){
                        result.Objects = pokemon
                        result.Correct = true
                    }
                }
                pokemonCompletionHandler(result)
            }
            task.resume()
        }
    }
        
        //    func performRequest() -> Result {
        //        var result = Result()
        //        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=829") {
        //            let session = URLSession(configuration: .default)
        //            let task = session.dataTask(with: url) { data, response, error in
        //                if error != nil {
        //                    result.Correct = false
        //                    result.ErrorMessage = error!.localizedDescription
        //                    result.Ex = error
        //                }
        //
        //                if let safeData = data {
        //                    if let pokemon = self.parseJSON(pokemonData: safeData){
        //                        result.Objects = pokemon
        //                        result.Correct = true
        //                    }
        //                }
        //            }
        //            task.resume()
        //        }
        //        return result
        //    }
        
    func parseJSON(pokemonData: Data) -> [PokemonModel]? {
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemon = decodeData.results?.map {
                PokemonModel(name: $0.name , imageUrl: $0.url )
            }
            return pokemon
        } catch {
            return nil
        }
    }
}
