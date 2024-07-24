//
//  HomeProtocols.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.


protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    func showError()
    func reloadData()
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfPokemons() -> Int
    func pokemon(at: Int) -> PokemonData?
    func loadMorePokemons()
    func showDetail(at: Int)
    
}

protocol HomeRouterProtocol: AnyObject {
    func showDetail(pokemon: PokemonData)
}

protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomeInteractorOutProtocol? { get set }
    func getPokemonData()
}

protocol HomeInteractorOutProtocol: AnyObject {
    func setPokemons(pokemons: [PokemonData])
    func getPokemonsError()
    func withoutResults()
}

