//
//  Navigation.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 20/4/24.
//

import SwiftUI

enum NavigationStatus: Hashable {
    case characterDetail(CharacterModel)
    case episodeDetail(String)
}

extension View {
    func mainNavigation() -> some View {
        self.navigationDestination(for: NavigationStatus.self) { status in
            switch status {
            case let .characterDetail(char):
                CharacterDetailView(character: char)
            case let .episodeDetail(episode):
                Text(episode)
            }
        }
    }
}
