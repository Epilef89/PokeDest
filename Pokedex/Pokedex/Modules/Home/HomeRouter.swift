//
//  HomeRouter.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.

import UIKit

final class HomeRouter: HomeRouterProtocol {
    
    // MARK: Private var - let
    private weak var viewController: UIViewController?
    
    // MARK: Init
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: Public func
    func showDetail(pokemon: PokemonData) {
        let detailViewController = DetailBuilder.build(pokemonData: pokemon)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: Private func
    
}

