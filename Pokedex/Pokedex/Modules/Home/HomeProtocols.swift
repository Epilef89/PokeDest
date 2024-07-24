//
//  HomeProtocols.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.


protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    func showError()
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol HomeRouterProtocol: AnyObject {

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

