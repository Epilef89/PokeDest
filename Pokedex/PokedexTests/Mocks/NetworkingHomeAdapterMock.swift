//
//  NetworkingHomeAdapterMock.swift
//  PokedexTests
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation
@testable import Pokedex

class NetworkingHomeAdapterMock: NetworkingHomeAdapterProtocol {
    
    private let success: Bool
    private let withData: Bool
    
    init(success: Bool = true, withData: Bool = true) {
        self.success = success
        self.withData = withData
    }
    
    func getPokemons(limit: Int, offset: Int, completion: @escaping (PokemonListResponse?, NSError?) -> Void) {
        guard success else {
            completion(nil, NetworkError.badResponse.error)
            return
        }
        guard withData else {
            completion(DummyData.pokemonListLastResult, nil)
            return
        }
        completion(DummyData.pokemonList, nil)
    }
    
    func getPokemonInfo(pokemons: [PokemonListResponse.PokemonResult], completion: @escaping ([PokemonData]?, NSError?) -> Void) {
        guard success else {
            completion(nil, NetworkError.badResponse.error)
            return
        }
        completion(DummyData.pokemonData, nil)
        
    }

    
}
