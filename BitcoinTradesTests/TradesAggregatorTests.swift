//
//  TradesAggregatorTests.swift
//  BitcoinTradesTests
//
//  Created by Pawel Jurczyk on 23/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import XCTest
@testable import BitcoinTrades

class TradesAggregatorTests: XCTestCase {

    var mockTradesService: MockTradesService!
    var mockRESTTradesService: MockTradesService!
    var aggregator: TradesAggregator!

    override func setUp() {
        mockTradesService = MockTradesService()
        mockRESTTradesService = MockTradesService()
        aggregator = TradesAggregator(tradeService: mockTradesService,
                                      restTradeService: mockRESTTradesService)
    }

    override func tearDown() {
        mockTradesService = nil
        mockRESTTradesService = nil
        aggregator = nil
    }

    func testTradeServiceStartWasCalled() {
        aggregator.startTradeService()
        XCTAssert(mockTradesService.startWasCalled)
        XCTAssertFalse(mockTradesService.stopWasCalled)
        XCTAssertFalse(mockRESTTradesService.startWasCalled)
    }

    func testTradeServiceStartWasCalledAfter100Trades() {
        aggregator.startTradeService()
        triggerTrades(tradesService: mockTradesService, count: 100)
        
        let e = expectation(description: "StartWasCalled")
        mockRESTTradesService.onStartCalled = { e.fulfill() }
        wait(for: [e], timeout: 0.5)
    }

    func testRESTTradeServiceStopWasCalledAfter25Trades() {
        aggregator.startTradeService()
        triggerTrades(tradesService: mockTradesService, count: 100)
        let e1 = expectation(description: "StartWasCalled")
        mockRESTTradesService.onStartCalled = { e1.fulfill() }
        wait(for: [e1], timeout: 0.5)
        triggerTrades(tradesService: mockRESTTradesService, count: 25)
        
        let e2 = expectation(description: "StopWasCalled")
        mockRESTTradesService.onStopCalled = { e2.fulfill() }
        wait(for: [e2], timeout: 0.5)
    }
}

extension TradesAggregatorTests {
    func triggerTrades(tradesService: TradesService, count: Int) {
        let trade = Trade(data: Trade.PayloadData(timestamp: "0", price: 1), sentiment: 0)
        for _ in 1...count {
            tradesService.newTradeCallback?(trade)
        }
    }
}
