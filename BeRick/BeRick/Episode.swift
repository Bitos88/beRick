//
//  Episode.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 21/4/24.
//

import Foundation

struct Episode: Identifiable, Hashable{
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [URL]
}
