//
//  HomePresenter.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.


final class HomePresenter: HomePresenterProtocol {
    
    // MARK: Private var - let
    private weak var view: HomeViewProtocol?
    private var router: HomeRouterProtocol
    private var interactor: HomeInteractorProtocol
    
    // MARK: Init
    init(view: HomeViewProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    // MARK: Public func
    func viewDidLoad() {
        
    }
    
    // MARK: Private func

}

// MARK: HomeInteractorOutProtocol
extension HomePresenter: HomeInteractorOutProtocol {
    
}
