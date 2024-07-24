//
//  DetailPresenterTest.swift
//  Created by David Felipe Cortes Gonzalez on 24/07/24.
//  Copyright (c) 2024. All rights reserved.

@testable import Pokedex
import XCTest

final class DetailPresenterTest: XCTestCase {
    
    // MARK: Subject under test
    private var interactor: StubDetailInteractor!
    private var router: StubDetailRouter!
    private var view: StubDetailView!
    private var sut: DetailPresenter!
    
    // MARK: Init
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupDetailPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupDetailPresenter() {
        view = StubDetailView()
        router = StubDetailRouter()
        interactor = StubDetailInteractor()
        guard let pokemonData = DummyData.pokemonData.first else { return }
        sut = DetailPresenter(view: view, router: router, interactor: interactor, pokemonData: pokemonData)
    }
    
    // MARK: Tests
    
    func testViewDidLoad() {
        // Given
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(view.invocations, [.updateView])
    }

}

// MARK: StubDetailInteractor

private extension DetailPresenterTest {
    
    class StubDetailInteractor: DetailInteractorProtocol {
        var presenter: DetailInteractorOutProtocol?
        /*var invocations: [Invocation] = []
        enum Invocation {
            case someFunc
        }
        
        // MARK: StubDetailInteractorProtocol implementations
        func someFunc() {
            invocations.append(.someFunc)
        }*/
    }
}

// MARK: StubDetailRouter

private extension DetailPresenterTest {
    
    class StubDetailRouter: DetailRouterProtocol {
        /*var invocations: [Invocation] = []
        enum Invocation {
            case someFunc
        }
        
        // MARK: StubDetailRouterProtocol implementations
        func someFunc() {
            invocations.append(.someFunc)
        }*/
    }
}

private extension DetailPresenterTest {
    class StubDetailView: DetailViewProtocol {
        var presenter: DetailPresenterProtocol?
        var invocations: [Invocation] = []
        enum Invocation {
            case showError
            case updateView
        }
        
        // MARK: StubDetailViewProtocol implementations
        func showError() {
            invocations.append(.showError)
        }
        
        func updateView(with pokemonData: Pokedex.PokemonData) {
            invocations.append(.updateView)
        }
    }
}
