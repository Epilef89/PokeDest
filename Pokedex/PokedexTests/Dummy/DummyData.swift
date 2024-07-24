//
//  DummyData.swift
//  PokedexTests
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation
@testable import Pokedex

struct DummyData {
    static let pokemonList: PokemonListResponse = PokemonListResponse(count: 1302,
                                                                      next: "https://pokeapi.co/api/v2/pokemon?offset=5&limit=5",
                                                                      previous: nil,
                                                                      results: [ PokemonListResponse.PokemonResult(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
                                                                                 PokemonListResponse.PokemonResult(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
                                                                                 PokemonListResponse.PokemonResult(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
                                                                                 PokemonListResponse.PokemonResult(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"),
                                                                                 PokemonListResponse.PokemonResult(name: "charmeleon", url: "https://pokeapi.co/api/v2/pokemon/5/"),
                                                                               ])
    static let pokemonListLastResult: PokemonListResponse = PokemonListResponse(count: 1302,
                                                                                next: nil,
                                                                                previous: nil,
                                                                                results: [ PokemonListResponse.PokemonResult(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
                                                                                           PokemonListResponse.PokemonResult(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
                                                                                           PokemonListResponse.PokemonResult(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
                                                                                           PokemonListResponse.PokemonResult(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"),
                                                                                           PokemonListResponse.PokemonResult(name: "charmeleon", url: "https://pokeapi.co/api/v2/pokemon/5/"),
                                                                                         ])
    static let pokemonData: [PokemonData] = [PokemonData(name: "bulbasaur", description: "", imageURL: "", abilities: []),
                                             PokemonData(name: "ivysaur", description: "", imageURL: "", abilities: []),
                                             PokemonData(name: "venusaur", description: "", imageURL: "", abilities: []),
                                             PokemonData(name: "charmander", description: "", imageURL: "", abilities: []),
                                             PokemonData(name: "charmeleon", description: "", imageURL: "", abilities: [])]
}
