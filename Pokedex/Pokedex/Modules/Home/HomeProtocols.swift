//
//  HomeProtocols.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.


protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol HomeRouterProtocol: AnyObject {

}

protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomeInteractorOutProtocol? { get set }
}

protocol HomeInteractorOutProtocol: AnyObject {
    
}

