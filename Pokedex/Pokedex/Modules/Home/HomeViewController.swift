//
//  HomeViewController.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: var - let
    var presenter: HomePresenterProtocol?
    
    // MARK: Private var -let

    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view?.backgroundColor = .red
    }
    
    // MARK: Private func

}

// MARK: HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    
}
