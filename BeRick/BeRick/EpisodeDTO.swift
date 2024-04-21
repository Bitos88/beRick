//
//  EpisodeDTO.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 21/4/24.
//

import Foundation

struct EpisodeDTO: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [URL]
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters
        case airDate = "air_date"
    }
    
    var toEpisodeModel: Episode {
        Episode(
            id: id,
            name: name,
            airDate: airDate,
            episode: episode,
            characters: characters
        )
    }
}
