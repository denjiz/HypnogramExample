//
//  PreviewHypnogramDataRepository.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 09.11.2024..
//

import Foundation

class PreviewHypnogramDataRepository: HypnogramDataRepository {
    let lastNightData: [HypnogramDataPoint]
    
    init(lastNightData: [HypnogramDataPoint]) {
        self.lastNightData = lastNightData
    }
}

extension PreviewHypnogramDataRepository {
    
    static func withSampleData() -> PreviewHypnogramDataRepository {
        let startOfToday = Calendar.current.startOfDay(for: .now)
        let hypnogramDataStart = startOfToday - 2*60*60
        
        let sampleData = [
            HypnogramDataPoint(date: hypnogramDataStart,              phase: "Awake"),
            HypnogramDataPoint(date: hypnogramDataStart + 15*60,      phase: "Awake"),
            HypnogramDataPoint(date: hypnogramDataStart + 15*60 + 30, phase: "REM"),
            HypnogramDataPoint(date: hypnogramDataStart + 30*60,      phase: "REM"),
            HypnogramDataPoint(date: hypnogramDataStart + 30*60 + 30, phase: "Core"),
            HypnogramDataPoint(date: hypnogramDataStart + 45*60,      phase: "Core"),
            HypnogramDataPoint(date: hypnogramDataStart + 45*60 + 30, phase: "Deep"),
            HypnogramDataPoint(date: hypnogramDataStart + 75*60,      phase: "Deep"),
            HypnogramDataPoint(date: hypnogramDataStart + 75*60 + 30, phase: "Core"),
            HypnogramDataPoint(date: hypnogramDataStart + 90*60,      phase: "Core")
        ]
        
        let respository = PreviewHypnogramDataRepository(lastNightData: sampleData)
        return respository
    }
}
