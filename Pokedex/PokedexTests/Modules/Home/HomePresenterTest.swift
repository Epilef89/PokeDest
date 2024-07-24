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
        interactor.presenter = sut
    }
    
    // MARK: Tests
    func testViewDidLoad() {
        // Given
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(interactor.invocations, [.getPokemonData])
    }
    
    func testLoadMorePokemons() {
        // Given
        sut.viewDidLoad()
        view.invocations = []
        // When
        sut.loadMorePokemons()
        
        // Then
        XCTAssertEqual(view.invocations, [.reloadData])
        XCTAssertEqual(interactor.invocations, [.getPokemonData, .getPokemonData])
    }
    
    func testShowDetail() {
        // Given
        sut.viewDidLoad()
        // When
        sut.showDetail(at: .zero)
        
        // Then
        XCTAssertEqual(interactor.invocations, [.getPokemonData])
        XCTAssertEqual(router.invocations, [.showDetail])
    }
    
    func testShowDetailError() {
        // Given
        sut.viewDidLoad()
        view.invocations = []
        // When
        sut.showDetail(at: 1000)
        
        // Then
        XCTAssertEqual(interactor.invocations, [.getPokemonData])
        XCTAssertEqual(router.invocations, [])
        XCTAssertEqual(view.invocations, [.showError])
    }
    
    func testGetPokemonsError() {
        // Given
        
        // When
        sut.getPokemonsError()
        
        // Then
        XCTAssertEqual(view.invocations, [.showError])
    }
    
    func testWithoutResults() {
        // Given
        
        // When
        sut.withoutResults()
        
        // Then
        XCTAssertEqual(view.invocations, [.showError])
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
            presenter?.setPokemons(pokemons: DummyData.pokemonData)
            invocations.append(.getPokemonData)
        }
    }
}

// MARK: StubHomeRouter

private extension HomePresenterTest {
    
    class StubHomeRouter: HomeRouterProtocol {
        var invocations: [Invocation] = []
        enum Invocation {
            case showDetail
        }
        
        // MARK: StubHomeRouterProtocol implementations
        func showDetail(pokemon: Pokedex.PokemonData) {
            invocations.append(.showDetail)
        }
    }
}

private extension HomePresenterTest {
    class StubHomeView: HomeViewProtocol {
        var presenter: HomePresenterProtocol?
        var invocations: [Invocation] = []
        enum Invocation {
            case showError
            case reloadData
        }
        
        // MARK: StubHomeViewProtocol implementations
        func showError() {
            invocations.append(.showError)
        }
        
        func reloadData() {
            invocations.append(.reloadData)
        }
    }
}
