//
//  HypnogramExampleApp.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 09.11.2024..
//

import SwiftUI

@main
struct HypnogramExampleApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                homeView
            }
        }
    }
    
    private var homeView: HomeView {
        HomeView(viewModel: HomeViewModel(
            repository: ExampleHypnogramDataRepository() // inject example data
        ))
    }
}
