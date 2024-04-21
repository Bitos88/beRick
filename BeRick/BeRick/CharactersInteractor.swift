//
//  CharactersInteractor.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import Foundation

protocol CharacterInteractorProtocol {
    func getCharacters(status: CharacterStatus, page: Int, searchText: String) async throws -> [CharacterModel]
    func getCharacterEpisodes(episodes: String) async throws -> [Episode]
}

struct CharactersInteractor: CharacterInteractorProtocol, NetworkInteractorProtocol {
    let session: URLSession
    
    static let shared = CharactersInteractor()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCharacters(status: CharacterStatus, page: Int, searchText: String) async throws -> [CharacterModel] {
        var params = ["page" : String(page)]
        
        if status != .all {
            params["status"] = status.rawValue
        }
        
        if !searchText.isEmpty {
            params["name"] = searchText
        }
        
        return try await getJSON(request: .get(url: .charactersURL, params: params), type: CharactersResponseDTO.self).results.map(\.mapToModel)
    }
    
    func getCharacterEpisodes(episodes: String) async throws -> [Episode] {
        return try await getJSON(request: .get(url: .getMultipleEpisodesURL(episodes: episodes), params: [:]), type: [EpisodeDTO].self).map(\.toEpisodeModel)
    }
}
