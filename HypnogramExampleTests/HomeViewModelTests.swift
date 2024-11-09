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
        let startTimeInterval: TimeInterval = 1731099600
        
        return [
            TestCaseData(
                repositoryData: [
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval),       phase: "Awake"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 30),  phase: "Awake"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 60),  phase: "Awake"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 90),  phase: "REM"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 120), phase: "REM"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 150), phase: "REM"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 180), phase: "Core"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 210), phase: "Core"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 240), phase: "Core"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 270), phase: "Deep"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 300), phase: "Deep"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 330), phase: "Deep"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 270), phase: "Deep"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 300), phase: "Core"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 330), phase: "Core")
                ],
                expectedViewData: [
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval),       phase: "Awake"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 60),  phase: "Awake"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 90),  phase: "REM"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 150), phase: "REM"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 180), phase: "Core"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 240), phase: "Core"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 270), phase: "Deep"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 270), phase: "Deep"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 300), phase: "Core"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 330), phase: "Core")
                ]
            ),
            TestCaseData(
                repositoryData: [
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval),       phase: "Awake"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 30),  phase: "Deep"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 60),  phase: "REM"),
                    HypnogramDataPoint(date: Date(timeIntervalSince1970: startTimeInterval + 90),  phase: "Core")
                ],
                expectedViewData: [
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval),       phase: "Awake"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 30),  phase: "Deep"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 60),  phase: "REM"),
                    HypnogramMarkData(date: Date(timeIntervalSince1970: startTimeInterval + 90),  phase: "Core")
                ]
            ),
            TestCaseData(
                repositoryData: [],
                expectedViewData: []
            )
        ]
    }
}
