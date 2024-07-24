//
//  HomeInteractorTest.swift
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//  Copyright (c) 2024. All rights reserved.
//

@testable import Pokedex
import XCTest

final class HomeInteractorTest: XCTestCase {
    
    // MARK: Subject under test
    private var presenter: StubHomeInteractorOutProtocol!
    private var sut: HomeInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupHomeInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupHomeInteractor() {
        sut = HomeInteractor()
        presenter = StubHomeInteractorOutProtocol()
        sut.presenter = presenter
    }
    
    // MARK: Tests
    
    func testGetPokemonData() {
        // Given
        sut = HomeInteractor(networkingHomeAdapter: NetworkingHomeAdapterMock(success: true))
        presenter = StubHomeInteractorOutProtocol()
        sut.presenter = presenter
        // When
        sut.getPokemonData()
        
        // Then
        XCTAssertEqual(presenter.invocations, [.setPokemons])
    }
    
    func testGetPokemonDataError() {
        // Given
        sut = HomeInteractor(networkingHomeAdapter: NetworkingHomeAdapterMock(success: false))
        presenter = StubHomeInteractorOutProtocol()
        sut.presenter = presenter
        // When
        sut.getPokemonData()
        
        // Then
        XCTAssertEqual(presenter.invocations, [.getPokemonsError])
    }
    
    func testGetPokemonDataWithoutData() {
        // Given
        sut = HomeInteractor(networkingHomeAdapter: NetworkingHomeAdapterMock(success: true, withData: false))
        presenter = StubHomeInteractorOutProtocol()
        sut.presenter = presenter
        sut.getPokemonData()
        
        // When
        sut.getPokemonData()
        
        // Then
        XCTAssertEqual(presenter.invocations, [.setPokemons, .withoutResults])
    }
}

private extension HomeInteractorTest {
    
    class StubHomeInteractorOutProtocol: HomeInteractorOutProtocol {
        
        var invocations: [Invocation] = []
        
        enum Invocation {
            case setPokemons
            case getPokemonsError
            case withoutResults
        }
        
        // MARK: Stub HomeInteractorOutProtocol implementations
        func setPokemons(pokemons: [PokemonData]) {
            invocations.append(.setPokemons)
        }
        
        func getPokemonsError() {
            invocations.append(.getPokemonsError)
        }
        
        func withoutResults() {
            invocations.append(.withoutResults)
        }
    }
}

