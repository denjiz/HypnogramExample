//
//  HomeView.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 09.11.2024..
//

import SwiftUI

struct HomeView: View {
    private let texts = UITexts.Home.self
    
    var body: some View {
        Text("No data yet")
            .navigationTitle(texts.title)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
