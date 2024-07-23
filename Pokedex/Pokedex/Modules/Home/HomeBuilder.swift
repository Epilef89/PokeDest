//
//  HomeBuilder.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.


final class HomeBuilder {
    
    static func build() -> HomeViewController {
        let viewController = HomeViewController()
        let router =  HomeRouter(viewController: viewController)
        let interactor = HomeInteractor()
        let presenter: HomePresenterProtocol & HomeInteractorOutProtocol = HomePresenter(view: viewController, router: router, interactor: interactor)
        interactor.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
}
