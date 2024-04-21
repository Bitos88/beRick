//
//  TestData.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 19/4/24.
//

import Foundation

struct CharacterInteractorTest: CharacterInteractorProtocol {    
    func getCharacterEpisodes(episodes: String) async throws -> [Episode] {
        [.testEpisode, .testEpisode, .testEpisode, .testEpisode]
    }
    
    func getCharacters(status: CharacterStatus, page: Int, searchText: String) async throws -> [CharacterModel] {
        let url = Bundle.main.url(forResource: "RickMock", withExtension: "json")!
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormat())
        
        let characters = try decoder.decode(CharactersResponseDTO.self, from: data).results.map(\.mapToModel)
        
        if !searchText.isEmpty {
            return characters.filter( { $0.name.localizedStandardContains(searchText) })
        }
        
        if status != .all {
            return characters.filter( { $0.status == status} )
        }
        
        return characters
    }
}

extension CharacterListViewModel {
    static let testVM = CharacterListViewModel(interactor: CharacterInteractorTest())
}

extension CharacterModel {
    static let testCharacter = CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        gender: .male,
        image: URL(
            string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        )!,
        episode: [],
        species: "Human",
        created: .now
    )
}

extension Episode {
    static let testEpisode = Episode(id: 1, name: "TestEpisode", airDate: "April 7, 2014", episode: "S01E10", characters: [])
}


