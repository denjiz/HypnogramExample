//
//  UITexts.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 09.11.2024..
//

import Foundation

enum UITexts {
    
    enum Generic {
        static let start = "start"
        static let end = "end"
    }
    
    enum Home {
        static let title = "Last Night's Sleep"
        
        enum Chart {
            static let totalRecordingIntervalTitle = "Data recorded for a total of:"
            
            private static let totalRecordingIntervalFormatter: DateComponentsFormatter = {
                let formatter = DateComponentsFormatter()
                formatter.allowedUnits = [.hour, .minute]
                formatter.unitsStyle = .abbreviated
                return formatter
            }()
            
            static func totalRecordingIntervalString(startDate: Date?, endDate: Date?) -> String? {
                guard let startDate, let endDate else { return nil }
                let timeInterval = endDate.timeIntervalSince(startDate)
                let intervalString = totalRecordingIntervalFormatter.string(from: timeInterval)
                return intervalString
            }
        }
    }
}
