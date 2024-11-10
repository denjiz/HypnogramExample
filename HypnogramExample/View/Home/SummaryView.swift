//
//  SummaryView.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 10.11.2024..
//

import SwiftUI

struct SummaryView: View {
    let startDate: Date?
    let endDate: Date?
    
    private let texts = UITexts.Home.Summary.self
    
    var body: some View {
        if let totalRecordingInterval {
            totalRecordingIntervalView(for: totalRecordingInterval)
        }
    }
    
    private func totalRecordingIntervalView(for interval: String) -> some View {
        VStack(alignment: .leading) {
            totalRecordingIntervalTitle
            totalRecordingIntervalText(for: interval)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var totalRecordingIntervalTitle: some View {
        Text(texts.totalRecordingIntervalTitle)
    }
    
    private func totalRecordingIntervalText(for interval: String) -> some View {
        Text(interval)
            .font(.title)
            .fontWeight(.bold)
    }
}

fileprivate extension SummaryView {
    
    var totalRecordingInterval: String? {
        texts.totalRecordingIntervalString(
            startDate: startDate,
            endDate: endDate
        )
    }
}

#Preview {
    SummaryView(
        startDate: .now,
        endDate: .now + 457*60
    )
}
