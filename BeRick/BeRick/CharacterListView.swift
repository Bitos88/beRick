//
//  CharacterListView.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import SwiftUI

struct CharacterListView: View {
    @EnvironmentObject var vm: CharacterListViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if vm.characters.isEmpty {
                    ContentUnavailableView("No characters",
                                           systemImage: "person.fill",
                                           description: Text("There's no characters named '**\(vm.searchText)**'."))
                }
                
                ForEach(vm.characters) { character in
                    NavigationLink(value: character) {
                        CharacterListCell(character: character)
                            .onAppear {
                                vm.checkLastItem(character: character)
                            }
                    }
                }
            }
            .navigationDestination(for: CharacterModel.self, destination: { char in
                CharacterDetailView(character: char)
            })
            
            .navigationTitle("Rick & Morty")
            //.mainNavigation()
            .mainToolbar(status: $vm.characterStatus)
            .searchable(text: $vm.searchText)
            .onChange(of: vm.searchText) {
                Task {
                    try await Task.sleep(nanoseconds: 500_000_000)
                    await vm.getCharacters()
                }
            }
            .alert("Something went wrong loading the data.", isPresented: $vm.showAlert) {
                Button(action: {
                    Task { await vm.getCharacters() }
                }, label: {
                    Text("Try again")
                })
            } message: {
                VStack {
                    Text("Please try again later")
                }
            }
        }
    }
}

#Preview {
    CharacterListView()
        .environmentObject(CharacterListViewModel.testVM)
}
