//
//  NetworkingHomeAdapter.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.
//

import Foundation

protocol NetworkingHomeAdapterProtocol {
    func getPokemons(limit: Int, offset: Int, completion: @escaping (PokemonListResponse?, NSError?) -> Void)
    func getPokemonInfo(pokemons: [PokemonListResponse.PokemonResult], completion: @escaping ([PokemonData]?, NSError?) -> Void)
}

final class NetworkingHomeAdapter: NetworkingHomeAdapterProtocol {
    
    // MARK: Private var - let
    
    // MARK: Init
    
    // MARK: Public func
    
    func getPokemons(limit: Int, offset: Int, completion: @escaping (PokemonListResponse?, NSError?) -> Void) {
        NetworkManager.request(router: APIPokemonRouter.getPokemons(offset: offset, limit: limit), responseOfType: PokemonListResponse.self) { response, result in
            switch result {
            case .success(let pokemons):
                completion(pokemons, nil)
            case .failure(let error):
                guard let error = error , error.isNetworkConnectionError else {
                    completion(nil, error)
                    return
                }
                completion(nil, error)
            }
        }
    }
    
    func getPokemonInfo(pokemons: [PokemonListResponse.PokemonResult], completion: @escaping ([PokemonData]?, NSError?) -> Void) {
        let dispatchGroupMain = DispatchGroup()
        var pokemonsData: [PokemonData] = []
        var errors: [NSError] = []
        let genericError: NSError = NSError(domain: "com.pokemon.api", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch some Pokemon data"])
        for pokemon in pokemons {
            dispatchGroupMain.enter()
            let dispatchGroup = DispatchGroup()
            var pokemonResponse: PokemonResponse?
            var description: String?
            dispatchGroup.enter()
            NetworkManager.request(router: APIPokemonRouter.pokemonDetail(id: pokemon.name), responseOfType: PokemonResponse.self) { response, result in
                switch result {
                case .success(let pokemonData):
                    pokemonResponse = pokemonData
                case .failure(let error):
                    guard let error = error else {
                        errors.append(genericError)
                        return
                    }
                    errors.append(error)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            NetworkManager.request(router: APIPokemonRouter.pokemonSpecies(id: pokemon.name), responseOfType: PokemonSpeciesResponse.self) { response, result in
                switch result {
                case .success(let pokemonSpecie):
                    description = pokemonSpecie.flavorTextEntries.first(where: { $0.language.name == "en" })?.flavorText
                case .failure(let error):
                    guard let error = error else {
                        errors.append(genericError)
                        return
                    }
                    errors.append(error)
                }
                dispatchGroup.leave()
            }

            dispatchGroup.notify(queue: .main) {
                guard let pokemonResponse = pokemonResponse, let description = description else {
                    dispatchGroupMain.leave()
                    return
                }
                let abilities = pokemonResponse.abilities.map { $0.ability.name }
                let pokemonData = PokemonData(
                    name: pokemonResponse.name,
                    description: description,
                    imageURL: pokemonResponse.sprites.frontDefault,
                    abilities: abilities
                )
                pokemonsData.append(pokemonData)
                dispatchGroupMain.leave()
            }
        }

        dispatchGroupMain.notify(queue: .main) {
            completion(pokemonsData, errors.first)
        }
    }

    // MARK: Private func
}

