//
//  PokemonSpeciesResponse.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation

struct PokemonSpeciesResponse: Codable {
    let flavorTextEntries: [FlavorTextEntry]
    
    struct FlavorTextEntry: Codable {
        let flavorText: String
        let language: Language
        
        struct Language: Codable {
            let name: String
        }
        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
            case language
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}
