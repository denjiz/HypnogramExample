//
//  HomeViewModel.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 09.11.2024..
//

import Foundation

enum HypnogramPhase: String, CaseIterable {
    case awake = "Awake"
    case rem = "REM"
    case core = "Core"
    case deep = "Deep"
}

struct HypnogramMarkData: Identifiable, Equatable {
    let date: Date
    let phase: HypnogramPhase
    
    var id: String {
        "\(date.timeIntervalSince1970)-\(phase)"
    }
}

class HomeViewModel {
    let lastNightData: [HypnogramMarkData]
    
    init(repository: HypnogramDataRepository) {
        lastNightData = Self.viewData(from: repository.lastNightData)
    }
}

extension HomeViewModel {
    
    static func viewData(from repositoryData: [HypnogramDataPoint]) -> [HypnogramMarkData] {
        repositoryData
            .reduce(into: [[HypnogramDataPoint]]()) { currentResult, dataPoint in
                if currentResult.isEmpty ||
                    dataPoint.phase != currentResult[currentResult.count-1].last?.phase
                {
                    currentResult.append([dataPoint])
                } else {
                    currentResult[currentResult.count-1].append(dataPoint)
                }
            }
            .map { samePhaseDataPoints in
                if samePhaseDataPoints.count >= 3 {
                    return [samePhaseDataPoints.first!, samePhaseDataPoints.last!]
                }
                return samePhaseDataPoints
            }
            .flatMap { $0 }
            .map { dataPoint in
                guard let markPhase = HypnogramPhase(rawValue: dataPoint.phase) else {
                    fatalError("Repository data is not valid.")
                }
                let markDate = Date(timeIntervalSince1970: dataPoint.timestamp)
                
                return HypnogramMarkData(
                    date: markDate,
                    phase: markPhase
                )
            }
    }
}
