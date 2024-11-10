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
    private let chartTexts = UITexts.Home.Chart.self
    
    var body: some View {
        VStack(spacing: 60) {
            summaryView
            chart
        }
    }
    
    @ViewBuilder private var summaryView: some View {
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
        Text(chartTexts.totalRecordingIntervalTitle)
    }
    
    private func totalRecordingIntervalText(for interval: String) -> some View {
        Text(interval)
            .font(.title)
            .fontWeight(.bold)
    }
    
    private var chart: some View {
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

fileprivate extension HypnogramChart {
    
    var totalRecordingInterval: String? {
        chartTexts.totalRecordingIntervalString(
            startDate: data.first?.date,
            endDate: data.last?.date
        )
    }
}

#Preview("All phases") {
    let startOfToday = Calendar.current.startOfDay(for: .now)
    let hypnogramDataStart = startOfToday - 2*60*60
    
    HypnogramChart(data: [
        HypnogramMarkData(date: hypnogramDataStart,              phase: "Awake"),
        HypnogramMarkData(date: hypnogramDataStart + 15*60,      phase: "Awake"),
        HypnogramMarkData(date: hypnogramDataStart + 15*60 + 30, phase: "REM"),
        HypnogramMarkData(date: hypnogramDataStart + 30*60,      phase: "REM"),
        HypnogramMarkData(date: hypnogramDataStart + 30*60 + 30, phase: "Core"),
        HypnogramMarkData(date: hypnogramDataStart + 45*60,      phase: "Core"),
        HypnogramMarkData(date: hypnogramDataStart + 45*60 + 30, phase: "Deep"),
        HypnogramMarkData(date: hypnogramDataStart + 60*60,      phase: "Deep")
    ])
}

#Preview("9-hour range") {
    let startOfToday = Calendar.current.startOfDay(for: .now)
    let hypnogramDataStart = startOfToday - 2*60*60
    
    HypnogramChart(data: [
        HypnogramMarkData(date: hypnogramDataStart,           phase: "Awake"),
        HypnogramMarkData(date: hypnogramDataStart + 9*60*60, phase: "Awake"),
    ])
}
