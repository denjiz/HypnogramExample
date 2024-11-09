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
        Chart(data) { markData in
            LineMark(
                x: .value("Date", markData.date),
                y: .value("Phase", markData.phase)
            )
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour, count: 2)) {
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.hour().minute())
            }
        }
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
