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
            summaryAndChart
            Spacer()
        }
        .navigationTitle(texts.title)
    }
    
    private var summaryAndChart: some View {
        VStack(spacing: 60) {
            summaryView
            chart
        }
        .padding()
    }
    
    private var summaryView: some View {
        SummaryView(
            startDate: viewModel.lastNightData.first?.date,
            endDate: viewModel.lastNightData.last?.date
        )
    }
    
    private var chart: some View {
        HypnogramChart(data: viewModel.lastNightData)
            .frame(maxHeight: 300)
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: HomeViewModel(
            repository: PreviewHypnogramDataRepository.withSampleData()
        ))
    }
}
