//
//  DetailProtocols.swift
//  Created by David Felipe Cortes Gonzalez on 24/07/24.
//  Copyright (c) 2024. All rights reserved.


protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    func showError()
    func updateView(with pokemonData: PokemonData)
}

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol DetailRouterProtocol: AnyObject {

}

protocol DetailInteractorProtocol: AnyObject {
    var presenter: DetailInteractorOutProtocol? { get set }
}

protocol DetailInteractorOutProtocol: AnyObject {
    
}

