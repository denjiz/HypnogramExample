//
//  HomeView.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 09.11.2024..
//

import SwiftUI

struct HomeView: View {
    let viewModel: HomeViewModel
    private let texts = UITexts.Home.self
    
    var body: some View {
        VStack {
            chart
            Spacer()
        }
        .navigationTitle(texts.title)
    }
    
    @ViewBuilder private var chart: some View {
        HypnogramChart(data: viewModel.lastNightData)
            .frame(maxHeight: 300)
            .padding()
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: HomeViewModel(
            repository: PreviewHypnogramDataRepository.withSampleData()
        ))
    }
}
