//
//  ModelEnums.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import Foundation

enum CharacterStatus: String, Codable, CaseIterable, Identifiable {
    var id: Self { self }
    case all = "All"
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum CharacterGender: String, Codable {
    var id: Self { self }
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unkown = "unknown"
}
