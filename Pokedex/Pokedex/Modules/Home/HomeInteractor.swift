//
//  HomeInteractor.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.
//


final class HomeInteractor: HomeInteractorProtocol {
    
    // MARK: Public var - let
    weak var presenter: HomeInteractorOutProtocol?

    // MARK: Private var - let
    private var networkingHomeAdapter: NetworkingHomeAdapterProtocol?
    private let limit: Int = 30
    private var offset: Int = 0
    private var next: String? = ""
    private var pokemons: [PokemonData] = []
    
    // MARK: Init
    init(networkingHomeAdapter: NetworkingHomeAdapterProtocol = NetworkingHomeAdapter()) {
        self.networkingHomeAdapter = networkingHomeAdapter
    }
    
    // MARK: Public func
    func getPokemonData() {
        guard next != nil else {
            self.presenter?.withoutResults()
            return
        }
        networkingHomeAdapter?.getPokemons(limit: limit, offset: offset, completion: {[weak self] pokemonResponse, error in
            guard let self = self else { return }
            guard let pokemons = pokemonResponse else {
                self.presenter?.getPokemonsError()
                return
            }
            self.next = pokemons.next
            if pokemons.next != nil {
                self.offset += self.limit
            }
            getPokemonData(pokemonResult: pokemons.results)
        })
    }
    
    // MARK: Private func
    private func getPokemonData(pokemonResult: [PokemonListResponse.PokemonResult]) {
        networkingHomeAdapter?.getPokemonInfo(pokemons: pokemonResult, completion: { [weak self] pokemonsData, error in
            guard let self = self else { return }
            guard let pokemonsData = pokemonsData else {
                self.presenter?.getPokemonsError()
                return
            }
            self.presenter?.setPokemons(pokemons: pokemonsData)
        })
    }
}

