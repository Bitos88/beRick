//
//  CharacterListViewModel.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import Foundation

enum ViewState {
    case loadingData
    case dataLoaded
}

final class CharacterListViewModel: ObservableObject {
    let interactor: CharacterInteractorProtocol
    
    @Published var characters: [CharacterModel] = []
    @Published var characterEpisodes: [Episode] = []

    @Published var showAlert = false
    @Published var errorMessage = ""
    
    @Published var viewState: ViewState = .loadingData
    @Published var page: Int = 1
    @Published var searchText = "" {
        didSet {
            page = 1
        }
    }
    
    @Published var characterStatus: CharacterStatus = .all {
        didSet {
            page = 1
            Task { await getCharacters() }
        }
    }
                
    init(interactor: CharacterInteractorProtocol = CharactersInteractor.shared) {
        self.interactor = interactor
        
        Task(priority: .high) { await getCharacters() }
    }
    
    @MainActor
    func getCharacters() async {
        defer { viewState = .dataLoaded }
        
        viewState = .loadingData
        do {
            let characters = try await interactor.getCharacters(status: characterStatus, page: page, searchText: searchText)
            
            if page == 1 {
                self.characters.removeAll()
            }
            
            self.characters += characters
        } catch let error as NetworkError {
            if case let .status(code) = error, code == 404, page == 1 {
                characters = []
            }
            
        } catch {
            errorMessage = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    @MainActor 
    func getEpisodesForCharacter(character: CharacterModel) async {
        do {
            let episodes = try await interactor.getCharacterEpisodes(episodes: character.episode.joined(separator: ","))
        
            self.characterEpisodes = episodes
        } catch {
            errorMessage = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    func checkLastItem(character: CharacterModel) {
        if characters.last?.id == character.id {
            page += 1
            
            Task { await getCharacters() }
        }
    }
}
