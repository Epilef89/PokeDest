//
//  PokemonListResponse.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
    
    struct PokemonResult: Codable {
        let name: String
        let url: String
    }
}
