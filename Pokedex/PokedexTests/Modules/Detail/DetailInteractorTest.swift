//
//  DetailInteractorTest.swift
//  Created by David Felipe Cortes Gonzalez on 24/07/24.
//  Copyright (c) 2024. All rights reserved.
//

@testable import Pokedex
import XCTest

final class DetailInteractorTest: XCTestCase {
    
    // MARK: Subject under test
    private var presenter: StubDetailInteractorOutProtocol!
    private var sut: DetailInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupDetailInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupDetailInteractor() {
        sut = DetailInteractor()
        presenter = StubDetailInteractorOutProtocol()
        sut.presenter = presenter
    }
    
    // MARK: Tests
    
    /*func testSomeFunc(){
        // Given
        
        // When
        sut.testSomeFunc()
        
        // Then
        XCTAsserEqual(presenter.invocations, [.someFunc])
    }*/
}

private extension DetailInteractorTest {
    
    class StubDetailInteractorOutProtocol: DetailInteractorOutProtocol {
        
        /*var invocations: [Invocation] = []
        
        enum Invocation {
            case someFunc
        }
        
        // MARK: Stub DetailInteractorOutProtocol implementations
        
        func someFuncFromDetailInteractorOutProtocol() {
            invocations.append(.someFunc)
        }*/

    }
}

