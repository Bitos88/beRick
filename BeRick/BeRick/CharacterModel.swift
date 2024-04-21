//
//  CharacterModel.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import Foundation

struct CharacterModel: Identifiable, Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let gender: CharacterGender
    let image: URL
    let episode: [String]
    let species: String
    let created: Date
    
    var formattedCreated: String {
        created.formatted(date: .complete, time: .omitted)
    }
}
