//
//  PokemonData.swift
//  DGarciaJuegoPokemon
//
//  Created by MacBookMBA3 on 16/01/23.
//

import Foundation

struct PokemonData : Codable {
    let results : [Result]?
}

struct Result : Codable {
    let name: String
    let url : String
}
