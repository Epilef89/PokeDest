//
//  HomePresenter.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.


final class HomePresenter: HomePresenterProtocol {
    
    // MARK: Private var - let
    private weak var view: HomeViewProtocol?
    private var router: HomeRouterProtocol
    private var interactor: HomeInteractorProtocol
    private var pokemons: [PokemonData] = []
    
    // MARK: Init
    init(view: HomeViewProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    // MARK: Public func
    func viewDidLoad() {
        interactor.getPokemonData()
    }
    
    // MARK: Private func
    private func getMorePokemons() {
        interactor.getPokemonData()
    }

}

// MARK: HomeInteractorOutProtocol
extension HomePresenter: HomeInteractorOutProtocol {
    func setPokemons(pokemons: [PokemonData]) {
        self.pokemons.append(contentsOf: pokemons)
    }
    
    func getPokemonsError() {
        view?.showError()
    }
    
    func withoutResults() {
        print(pokemons.count)
    }
    
}
