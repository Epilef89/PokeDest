//
//  DetailBuilder.swift
//  Created by David Felipe Cortes Gonzalez on 24/07/24.
//  Copyright (c) 2024. All rights reserved.


final class DetailBuilder {
    
    static func build(pokemonData: PokemonData) -> DetailViewController {
        let viewController = DetailViewController()
        let router =  DetailRouter(viewController: viewController)
        let interactor = DetailInteractor()
        let presenter: DetailPresenterProtocol & DetailInteractorOutProtocol = DetailPresenter(view: viewController, router: router, interactor: interactor, pokemonData: pokemonData)
        interactor.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
}
