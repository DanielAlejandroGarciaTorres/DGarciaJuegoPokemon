//
//  PokemonData.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 16/01/23.
//

import Foundation

struct PokemonData : Codable {
    let results : [ResultPokemon]?
}

struct ResultPokemon : Codable {
    let name: String
    let url : String
}
