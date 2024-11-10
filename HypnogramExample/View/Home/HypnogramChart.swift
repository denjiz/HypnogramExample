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
            indicator(for: firstMarkData, label: "Start")
            indicator(for: lastMarkData, label: "End")
        }
    }
    
    private func indicator(for markData: HypnogramMarkData, label: String) -> some ChartContent {
        PointMark(
            x: .value("Date", markData.date),
            y: .value("Phase", markData.phase)
        )
        .annotation {
            VStack {
                Text(label)
                Text(markData.date, format: .dateTime.hour().minute())
            }
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
