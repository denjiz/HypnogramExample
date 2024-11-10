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
    private let texts = UITexts.Generic.self
    
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
            indicator(for: firstMarkData, label: texts.start.capitalized)
            indicator(for: lastMarkData, label: texts.end.capitalized)
        }
    }
    
    private func indicator(for markData: HypnogramMarkData, label: String) -> some ChartContent {
        indicatorMark(for: markData)
            .annotation(spacing: 0) {
                indicatorAnnotation(label: label, date: markData.date)
            }
    }
    
    private func indicatorMark(for markData: HypnogramMarkData) -> PointMark {
        PointMark(
            x: .value("Date", markData.date),
            y: .value("Phase", markData.phase)
        )
    }
    
    private func indicatorAnnotation(label: String, date: Date) -> some View {
        let backgroundColor = Color.black.opacity(0.8)
        
        return VStack(spacing: -1) {
            VStack {
                Text(label)
                Text(date, format: .dateTime.hour().minute())
            }
            .font(.callout)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 2)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(backgroundColor)
            )
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 8))
                .foregroundStyle(backgroundColor)
                .scaleEffect(x: 2)
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
