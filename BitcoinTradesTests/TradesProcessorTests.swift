//
//  TradesProcessorTests.swift
//  BitcoinTradesTests
//
//  Created by Pawel Jurczyk on 23/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import XCTest
@testable import BitcoinTrades

class TradesProcessorTests: XCTestCase {

    var tradesAggregator: TradesAggregator!

    override func setUp() {
        tradesAggregator = TradesAggregator(tradeService: MockTradesService(), restTradeService: MockTradesService())
    }

    override func tearDown() {
        tradesAggregator = nil
    }
    
    func testNumberOfRowsEqualNumberOfTrades() {
        let tradesProcessor = TradesProcessor(tradesAggregator: tradesAggregator)
        tradesProcessor.startTradeService()
        let trade = Trade(data: Trade.PayloadData(timestamp: "0", price: 1), sentiment: 0)
        for _ in 1...100 {
            tradesAggregator.processNewTrade?(trade)
        }
        
        XCTAssert(tradesProcessor.tableViewDataSource.cellModels.count == 100)
    }
    
    func testNumberOfRowsIs1After1001Trades() {
        let tradesProcessor = TradesProcessor(tradesAggregator: tradesAggregator)
        tradesProcessor.startTradeService()
        let trade = Trade(data: Trade.PayloadData(timestamp: "0", price: 1), sentiment: 0)
        for _ in 1...1001 {
            tradesAggregator.processNewTrade?(trade)
        }
        XCTAssert(tradesProcessor.tableViewDataSource.cellModels.count == 1)
    }
}
