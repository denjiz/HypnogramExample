//
//  HypnogramChart.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 09.11.2024..
//

import SwiftUI
import Charts

struct HypnogramChart: View {
    let data: [HypnogramMarkData]
    private let genericTexts = UITexts.Generic.self
    
    var body: some View {
        Chart {
            lineMarks
            startAndEndIndicators
         }
        .chartXAxis {
            xAxisContent
        }
        .chartYAxis {
            yAxisContent
        }
        .chartYScale(domain: HypnogramPhase.allCases)
    }
    
    private var lineMarks: some ChartContent {
        ForEach(data) { markData in
            LineMark(
                x: .value("Date", markData.date),
                y: .value("Phase", markData.phase)
            )
        }
    }
    
    @ChartContentBuilder private var startAndEndIndicators: some ChartContent {
        if let firstMarkData = data.first,
           let lastMarkData = data.last,
           firstMarkData != lastMarkData
        {
            highlightIndicator(for: firstMarkData, label: genericTexts.start.capitalized)
            highlightIndicator(for: lastMarkData, label: genericTexts.end.capitalized)
        }
    }
    
    private func highlightIndicator(for markData: HypnogramMarkData, label: String) -> some ChartContent {
        PointMark(
            x: .value("Date", markData.date),
            y: .value("Phase", markData.phase)
        )
        .annotation {
            HypnogramHighlightAnnotation(label: label, date: markData.date)
        }
    }
    
    private var xAxisContent: some AxisContent {
        AxisMarks(values: .stride(by: .hour, count: 2)) {
            AxisGridLine()
            AxisTick()
            AxisValueLabel(format: .dateTime.hour().minute())
        }
    }
    
    private var yAxisContent: some AxisContent {
        AxisMarks(preset: .extended)
    }
}

extension HypnogramPhase: Plottable {}

#Preview("All phases") {
    let startOfToday = Calendar.current.startOfDay(for: .now)
    let hypnogramDataStart = startOfToday - 2*60*60
    
    HypnogramChart(data: [
        HypnogramMarkData(date: hypnogramDataStart,              phase: .awake),
        HypnogramMarkData(date: hypnogramDataStart + 15*60,      phase: .awake),
        HypnogramMarkData(date: hypnogramDataStart + 15*60 + 30, phase: .rem),
        HypnogramMarkData(date: hypnogramDataStart + 30*60,      phase: .rem),
        HypnogramMarkData(date: hypnogramDataStart + 30*60 + 30, phase: .core),
        HypnogramMarkData(date: hypnogramDataStart + 45*60,      phase: .core),
        HypnogramMarkData(date: hypnogramDataStart + 45*60 + 30, phase: .deep),
        HypnogramMarkData(date: hypnogramDataStart + 60*60,      phase: .deep)
    ])
}

#Preview("One phase missing") {
    let startOfToday = Calendar.current.startOfDay(for: .now)
    let hypnogramDataStart = startOfToday - 2*60*60
    
    HypnogramChart(data: [
        HypnogramMarkData(date: hypnogramDataStart,              phase: .awake),
        HypnogramMarkData(date: hypnogramDataStart + 15*60,      phase: .awake),
        HypnogramMarkData(date: hypnogramDataStart + 15*60 + 30, phase: .rem),
        HypnogramMarkData(date: hypnogramDataStart + 30*60,      phase: .rem),
        HypnogramMarkData(date: hypnogramDataStart + 30*60 + 30, phase: .deep),
        HypnogramMarkData(date: hypnogramDataStart + 60*60,      phase: .deep)
    ])
}

#Preview("9-hour range") {
    let startOfToday = Calendar.current.startOfDay(for: .now)
    let hypnogramDataStart = startOfToday - 2*60*60
    
    HypnogramChart(data: [
        HypnogramMarkData(date: hypnogramDataStart,           phase: .awake),
        HypnogramMarkData(date: hypnogramDataStart + 9*60*60, phase: .awake)
    ])
}
