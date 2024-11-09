//
//  HomeViewModel.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 09.11.2024..
//

import Foundation

struct HypnogramMarkData: Identifiable, Equatable {
    let date: Date
    let phase: String
    
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
                let date = Date(timeIntervalSince1970: dataPoint.timestamp)
                let phase = dataPoint.phase
                
                return HypnogramMarkData(
                    date: date,
                    phase: phase
                )
            }
    }
}
