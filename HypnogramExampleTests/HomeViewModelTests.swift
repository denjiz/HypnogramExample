//
//  HomeViewModelTests.swift
//  HypnogramExampleTests
//
//  Created by Denis Mendica on 09.11.2024..
//

import Testing
import Foundation
@testable import HypnogramExample

struct HomeViewModelTests {

    @Test("Map repository data to view data", arguments: testCasesData())
    func mapRepositoryDataToViewData(testCaseData: TestCaseData) {
        let repositoryData = testCaseData.repositoryData
        let expectedViewData = testCaseData.expectedViewData
        let repositoryStub = HypnogramDataRepositoryStub(lastNightData: repositoryData)
        let viewModel = HomeViewModel(repository: repositoryStub)
        
        let actualViewData = viewModel.lastNightData
        
        #expect(actualViewData == expectedViewData)
    }
}

extension HomeViewModelTests {
    
    struct TestCaseData {
        let repositoryData: [HypnogramDataPoint]
        let expectedViewData: [HypnogramMarkData]
    }
    
    static func testCasesData() -> [TestCaseData] {
        let startTimestamp: TimeInterval = 1731099600
        
        return [
            TestCaseData(
                repositoryData: [
                    HypnogramDataPoint(timestamp: startTimestamp,       phase: "Awake"),
                    HypnogramDataPoint(timestamp: startTimestamp + 30,  phase: "Awake"),
                    HypnogramDataPoint(timestamp: startTimestamp + 60,  phase: "Awake"),
                    HypnogramDataPoint(timestamp: startTimestamp + 90,  phase: "REM"),
                    HypnogramDataPoint(timestamp: startTimestamp + 120, phase: "REM"),
                    HypnogramDataPoint(timestamp: startTimestamp + 150, phase: "REM"),
                    HypnogramDataPoint(timestamp: startTimestamp + 180, phase: "Core"),
                    HypnogramDataPoint(timestamp: startTimestamp + 210, phase: "Core"),
                    HypnogramDataPoint(timestamp: startTimestamp + 240, phase: "Core"),
                    HypnogramDataPoint(timestamp: startTimestamp + 270, phase: "Deep"),
                    HypnogramDataPoint(timestamp: startTimestamp + 300, phase: "Deep"),
                    HypnogramDataPoint(timestamp: startTimestamp + 330, phase: "Deep"),
                    HypnogramDataPoint(timestamp: startTimestamp + 270, phase: "Deep"),
                    HypnogramDataPoint(timestamp: startTimestamp + 300, phase: "Core"),
                    HypnogramDataPoint(timestamp: startTimestamp + 330, phase: "Core")
                ],
                expectedViewData: [
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp),       phase: "Awake"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 60),  phase: "Awake"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 90),  phase: "REM"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 150), phase: "REM"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 180), phase: "Core"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 240), phase: "Core"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 270), phase: "Deep"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 270), phase: "Deep"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 300), phase: "Core"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 330), phase: "Core")
                ]
            ),
            TestCaseData(
                repositoryData: [
                    HypnogramDataPoint(timestamp: startTimestamp,      phase: "Awake"),
                    HypnogramDataPoint(timestamp: startTimestamp + 30, phase: "Deep"),
                    HypnogramDataPoint(timestamp: startTimestamp + 60, phase: "REM"),
                    HypnogramDataPoint(timestamp: startTimestamp + 90, phase: "Core")
                ],
                expectedViewData: [
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp),       phase: "Awake"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 30),  phase: "Deep"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 60),  phase: "REM"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimestamp + 90),  phase: "Core")
                ]
            ),
            TestCaseData(
                repositoryData: [],
                expectedViewData: []
            )
        ]
    }
}
