//
//  BeRickApp.swift
//  BeRick
//
//  Created by Alberto Alegre Bravo on 18/4/24.
//

import SwiftUI

@main
struct BeRickApp: App {
    @StateObject var vm = CharacterListViewModel()
    
    var body: some Scene {
        WindowGroup {
            CharacterListView()
                .environmentObject(vm)
        }
    }
}
