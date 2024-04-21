//
//  CharacterListCell.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import SwiftUI

struct CharacterListCell: View {
    let character: CharacterModel
    
    var body: some View {
        HStack {
            AsyncImage(url: character.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .clipShape(Circle())
            } placeholder: {
                Image(systemName: "popcorn")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                Text(character.name)
            }
        }
    }
}

#Preview {
    List {
        CharacterListCell(character: .testCharacter)
    }
}
