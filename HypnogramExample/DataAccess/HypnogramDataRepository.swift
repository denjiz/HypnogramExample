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

// This class holds the example data displayed in the app
class ExampleHypnogramDataRepository: HypnogramDataRepository {
    let lastNightData: [HypnogramDataPoint]
    
    init() {
        lastNightData = Self.readExampleData()
    }
    
    private static func readExampleData() -> [HypnogramDataPoint] {
        guard let fileURL = Bundle.main.url(forResource: "example_hypnogram_data", withExtension: "csv"),
              let textContent = try? String(contentsOf: fileURL)
        else {
            fatalError("Example data does not exist or is not valid")
        }
        
        let lines = textContent.split(whereSeparator: \.isNewline)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dataPoints = lines
            .dropFirst()
            .map { line in
                let components = line
                    .split(separator: ",")
                    .map { String($0) }
                
                guard components.count == 2,
                      let date = dateFormatter.date(from: components[0])
                else {
                    fatalError("Invalid example data")
                }
                
                let phase = components[1]
                return HypnogramDataPoint(date: date, phase: phase)
            }
        
        return dataPoints
    }
}
