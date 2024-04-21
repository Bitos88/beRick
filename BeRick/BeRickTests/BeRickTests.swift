//
//  BeRickTests.swift
//  BeRickTests
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import XCTest
@testable import BeRick

final class BeRickTests: XCTestCase {
    var interactor: CharactersInteractor!
    var sut: CharacterListViewModel!
    var characters: [CharacterModel]!
    var page: Int = 1
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [NetworkMockInterface.self]
        
        let session = URLSession(configuration: config)
        interactor = CharactersInteractor(session: session)
        sut = CharacterListViewModel(interactor: interactor)
        
    }

    override func tearDownWithError() throws {
        interactor = nil
        sut = nil
        characters = []
        page = 1
    }

    func testGetCharactersPageOne() async throws {
        let chars = try await interactor.getCharacters(status: .all, page: page, searchText: "")
        XCTAssertEqual(chars.count, 20)
    }
    
    func testGetCharactersNextPage() async throws {
        characters = try await interactor.getCharacters(status: .all, page: page, searchText: "")
        XCTAssertEqual(characters.count, 20)
        
        page += 1
        
        characters += try await interactor.getCharacters(status: .all, page: page, searchText: "")
        XCTAssertEqual(characters.count, 40)
    }
    
    func testChangeCharacterStatusVM() throws {
        let oldStatus = sut.characterStatus.rawValue
        
        sut.characterStatus = .dead
        
        XCTAssertNotEqual(oldStatus, sut.characterStatus.rawValue)
        XCTAssert(sut.characterStatus == .dead)
    }
    
    func testCheckLastCharacter() async throws {
        let chars = try await interactor.getCharacters(status: .all, page: page, searchText: "")
        
        let lastCharacter = chars.last!
        
        print(chars.last!)
        print(sut.page)
        
        sut.checkLastItem(character: lastCharacter)
        
        XCTAssert(sut.page == 2)
    }
}



