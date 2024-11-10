//
//  HypnogramDataRepository.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 09.11.2024..
//

import Foundation

protocol HypnogramDataRepository {
    var lastNightData: [HypnogramDataPoint] { get }
}

// In a real app, this class would be reponsible for fetching the actual
// data from a device (or from an API service, if the data was stored
// remotely on a server).
class DeviceHypnogramDataRepository {
    
    var lastNightData: [HypnogramDataPoint] {
        fatalError("Real data collection not implemented")
    }
}

// This class generates and provides the example data displayed in the app
class ExampleHypnogramDataRepository: HypnogramDataRepository {
    let lastNightData: [HypnogramDataPoint]
    
    init() {
        lastNightData = Self.generateExampleData()
    }
}

fileprivate extension ExampleHypnogramDataRepository {
    
    struct PhaseGenerationInfo {
        let phase: String
        let durationInMinutes: TimeInterval
    }
    
    private static let dataPointIntervalInSeconds: TimeInterval = 30
    
    static func generateExampleData() -> [HypnogramDataPoint] {
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let dataStartTimestamp = startOfToday.timeIntervalSince1970 - 2*60*60
        
        let phases = [
            PhaseGenerationInfo(phase: "Awake", durationInMinutes: 5),
            PhaseGenerationInfo(phase: "REM",   durationInMinutes: 5),
            PhaseGenerationInfo(phase: "Core",  durationInMinutes: 20),
            PhaseGenerationInfo(phase: "Deep",  durationInMinutes: 60),
            PhaseGenerationInfo(phase: "Core",  durationInMinutes: 20),
            PhaseGenerationInfo(phase: "REM",   durationInMinutes: 45),
            PhaseGenerationInfo(phase: "Core",  durationInMinutes: 30),
            PhaseGenerationInfo(phase: "Deep",  durationInMinutes: 10),
            PhaseGenerationInfo(phase: "Core",  durationInMinutes: 5),
            PhaseGenerationInfo(phase: "Deep",  durationInMinutes: 10),
            PhaseGenerationInfo(phase: "Core",  durationInMinutes: 40),
            PhaseGenerationInfo(phase: "REM",   durationInMinutes: 10),
            PhaseGenerationInfo(phase: "Awake", durationInMinutes: 1),
            PhaseGenerationInfo(phase: "REM",   durationInMinutes: 5),
            PhaseGenerationInfo(phase: "Core",  durationInMinutes: 2),
            PhaseGenerationInfo(phase: "REM",   durationInMinutes: 1),
            PhaseGenerationInfo(phase: "Awake", durationInMinutes: 2),
            PhaseGenerationInfo(phase: "REM",   durationInMinutes: 2),
            PhaseGenerationInfo(phase: "Core",  durationInMinutes: 1),
            PhaseGenerationInfo(phase: "REM",   durationInMinutes: 20),
            PhaseGenerationInfo(phase: "Core",  durationInMinutes: 5),
            PhaseGenerationInfo(phase: "REM",   durationInMinutes: 10),
            PhaseGenerationInfo(phase: "Core",  durationInMinutes: 30),
            PhaseGenerationInfo(phase: "REM",   durationInMinutes: 10),
            PhaseGenerationInfo(phase: "Core",  durationInMinutes: 5),
            PhaseGenerationInfo(phase: "REM",   durationInMinutes: 50),
            PhaseGenerationInfo(phase: "Awake", durationInMinutes: 70)
        ]
        
        let dataPoints = generateDataPoints(
            startTimestamp: dataStartTimestamp,
            phases: phases
        )
        
        return dataPoints
    }
    
    private static func generateDataPoints(
        startTimestamp: TimeInterval,
        phases: [PhaseGenerationInfo]
    ) -> [HypnogramDataPoint] {
        
        var dataPoints = [HypnogramDataPoint]()
        var nextPhaseStartTimestamp = startTimestamp
        for phase in phases {
            let dataPointCount = Int(phase.durationInMinutes * 60 / dataPointIntervalInSeconds)
            for i in 0..<dataPointCount {
                let dataPointTimestamp = nextPhaseStartTimestamp + Double(i) * dataPointIntervalInSeconds
                let dataPoint = HypnogramDataPoint(timestamp: dataPointTimestamp, phase: phase.phase)
                dataPoints.append(dataPoint)
            }
            nextPhaseStartTimestamp += Double(dataPointCount) * dataPointIntervalInSeconds
        }
        
        return dataPoints
    }
}
