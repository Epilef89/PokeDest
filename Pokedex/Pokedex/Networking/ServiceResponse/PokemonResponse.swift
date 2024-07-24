//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation

struct PokemonResponse: Codable {
    let name: String
    let sprites: Sprites
    let abilities: [AbilityInfo]
    
    struct Sprites: Codable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    
    struct AbilityInfo: Codable {
        let ability: Ability
        
        struct Ability: Codable {
            let name: String
        }
    }
}
