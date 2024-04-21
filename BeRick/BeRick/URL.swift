//
//  URL.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import Foundation

let mainURL = URL(string: "https://rickandmortyapi.com/api")!

extension URL {
    static let charactersURL = mainURL.appending(path: "character")
    static let episodesURL = mainURL.appending(path: "episode")
    
    
    static func getMultipleEpisodesURL(episodes: String) -> URL {
        URL.episodesURL.appending(path: episodes)
    }
}
