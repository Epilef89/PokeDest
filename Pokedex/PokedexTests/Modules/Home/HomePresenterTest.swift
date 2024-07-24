//
//  HomePresenterTest.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.

@testable import Pokedex
import XCTest

final class HomePresenterTest: XCTestCase {
    
    // MARK: Subject under test
    private var interactor: StubHomeInteractor!
    private var router: StubHomeRouter!
    private var view: StubHomeView!
    private var sut: HomePresenter!
    
    // MARK: Init
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupHomePresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupHomePresenter() {
        view = StubHomeView()
        router = StubHomeRouter()
        interactor = StubHomeInteractor()
        sut = HomePresenter(view: view, router: router, interactor: interactor)
    }
    
    // MARK: Tests
    func testViewDidLoad() {
        // Given
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(interactor.invocations, [.getPokemonData])
    }

}

// MARK: StubHomeInteractor

private extension HomePresenterTest {
    
    class StubHomeInteractor: HomeInteractorProtocol {
        var presenter: HomeInteractorOutProtocol?
        var invocations: [Invocation] = []
        enum Invocation {
            case getPokemonData
        }
        
        // MARK: StubHomeInteractorProtocol implementations
        func getPokemonData() {
            invocations.append(.getPokemonData)
        }
    }
}

// MARK: StubHomeRouter

private extension HomePresenterTest {
    
    class StubHomeRouter: HomeRouterProtocol {
        /*var invocations: [Invocation] = []
         enum Invocation {
         case someFunc
         }
         
         // MARK: StubHomeRouterProtocol implementations
         func someFunc() {
         invocations.append(.someFunc)
         }*/
    }
}

private extension HomePresenterTest {
    class StubHomeView: HomeViewProtocol {
        var presenter: HomePresenterProtocol?
        var invocations: [Invocation] = []
        enum Invocation {
            case showError
        }
        
        // MARK: StubHomeViewProtocol implementations
        func showError() {
            invocations.append(.showError)
        }
    }
}
