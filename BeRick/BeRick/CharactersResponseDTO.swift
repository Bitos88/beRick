//
//  CharactersResponseDTO.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import Foundation

struct CharactersResponseDTO: Codable {
    let info: CharacterResponseInfoDTO
    let results: [CharacterDTO]
}


struct CharacterResponseInfoDTO: Codable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}

struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let gender: CharacterGender
    let species: String
    let image: URL
    let episode: [URL]
    let created: Date
    
    var mapToModel: CharacterModel {
        CharacterModel(
            id: id,
            name: name,
            status: status,
            gender: gender,
            image: image,
            episode: episode.map(\.lastPathComponent),
            species: species,
            created: created
        )
    }
}
