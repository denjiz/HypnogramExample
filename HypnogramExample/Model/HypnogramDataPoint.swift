//
//  HypnogramDataPoint.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 09.11.2024..
//

import Foundation

/*
 This type models the raw data coming from a sleep-tracking device.
 */
struct HypnogramDataPoint {
    let timestamp: TimeInterval
    let phase: String
}
