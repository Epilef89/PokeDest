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
    private var isLoadingMore: Bool = false
    
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
    
    func numberOfPokemons() -> Int {
        return pokemons.count
    }
    
    func pokemon(at: Int) -> PokemonData? {
        return pokemons[safe: at]
    }
    
    func loadMorePokemons() {
        guard pokemons.count > .zero, !isLoadingMore  else { return }
        isLoadingMore.toggle()
        interactor.getPokemonData()
    }
    
    func showDetail(at: Int) {
        guard let pokemon = pokemons[safe: at] else {
            view?.showError()
            return
        }
        router.showDetail(pokemon: pokemon)
    }
    
    // MARK: Private func

}

// MARK: HomeInteractorOutProtocol
extension HomePresenter: HomeInteractorOutProtocol {
    func setPokemons(pokemons: [PokemonData]) {
        self.pokemons.append(contentsOf: pokemons)
        view?.reloadData()
        isLoadingMore = false
    }
    
    func getPokemonsError() {
        view?.showError()
    }
    
    func withoutResults() {
        view?.showError()
    }
    
}
