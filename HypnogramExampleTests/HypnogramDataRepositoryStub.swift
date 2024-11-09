//
//  HypnogramDataRepositoryStub.swift
//  HypnogramExampleTests
//
//  Created by Denis Mendica on 09.11.2024..
//

import Foundation
@testable import HypnogramExample

class HypnogramDataRepositoryStub: HypnogramDataRepository {
    var lastNightData: [HypnogramDataPoint]
    
    init(lastNightData: [HypnogramDataPoint]) {
        self.lastNightData = lastNightData
    }
}
