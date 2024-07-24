//
//  DetailPresenter.swift
//  Created by David Felipe Cortes Gonzalez on 24/07/24.
//  Copyright (c) 2024. All rights reserved.


final class DetailPresenter: DetailPresenterProtocol {
    
    // MARK: Private var - let
    private weak var view: DetailViewProtocol?
    private var router: DetailRouterProtocol
    private var interactor: DetailInteractorProtocol
    private let pokemonData: PokemonData
    
    // MARK: Init
    init(view: DetailViewProtocol, router: DetailRouterProtocol, interactor: DetailInteractorProtocol, pokemonData: PokemonData) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.pokemonData = pokemonData
    }

    // MARK: Public func
    func viewDidLoad() {
        view?.updateView(with: pokemonData)
    }
    
    // MARK: Private func

}

// MARK: DetailInteractorOutProtocol
extension DetailPresenter: DetailInteractorOutProtocol {
    
}
