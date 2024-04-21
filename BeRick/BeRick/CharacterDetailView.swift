//
//  CharacterDetailView.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterModel
    @EnvironmentObject var vm: CharacterListViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                AsyncImage(url: character.image) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
                
                VStack(alignment: .leading) {
                    Text("Gender: \(character.gender.rawValue)")
                    Text("Status: \(character.status.rawValue)")
                    
                    Text("Specie: \(character.species)")
                    Text("Created on: \(character.formattedCreated)")
                }
                .bold()
                
                DisclosureGroup(
                    content: {
                        ScrollView {
                            LazyVStack(alignment: .leading) {
                                ForEach(vm.characterEpisodes) { episode in
                                    EpisodeListCell(episode: episode)
                                }
                            }
                        }
                    },
                    label: {
                        Label("Episodes", systemImage: "list.and.film")
                    })
                
            }
            .padding()
            Spacer()
        }
        .onAppear {
            Task { await vm.getEpisodesForCharacter(character: character) }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CharacterDetailView(character: .testCharacter)
        .environmentObject(CharacterListViewModel.testVM)
}
