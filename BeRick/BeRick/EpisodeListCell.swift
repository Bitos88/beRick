//
//  EpisodeListCell.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 21/4/24.
//

import SwiftUI

struct EpisodeListCell: View {
    let episode: Episode
    
    var body: some View {
        HStack {
            Image(systemName: "sparkles.tv")
                .resizable()
                .scaledToFit()
                .frame(width: 26)
            VStack(alignment: .leading) {
                Text(episode.name)
                Text("Episode: \(episode.episode)")
            }
            .font(.subheadline)
            .padding(6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(4)
        .background(Color.cyan.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    LazyVStack {
        EpisodeListCell(episode: .testEpisode)
    }
}
