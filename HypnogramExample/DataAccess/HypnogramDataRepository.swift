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

/* In a real app, this class would be reponsible for fetching the actual
 data from a device (or from an API service, if the data was stored
 remotely on a server).
 */
class DeviceHypnogramDataRepository {
    
    var lastNightData: [HypnogramDataPoint] {
        fatalError("Real data collection not implemented")
    }
}
