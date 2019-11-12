//
//  CoinSentimentTests.swift
//  BitcoinTradesTests
//
//  Created by Pawel Jurczyk on 21/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import XCTest
@testable import BitcoinTrades

class CoinSentimentTests: XCTestCase {
    
    func testSentimentWithinRangeWithMinimumPrice() {
        let sentiment = coinSentiment(price: 2_000)
        XCTAssertGreaterThanOrEqual(sentiment, 0)
        XCTAssertLessThanOrEqual(sentiment, 1)
    }
    
    func testSentimentWithinRangeWithMaximumPrice() {
        let sentiment = coinSentiment(price: 18_000)
        XCTAssertGreaterThanOrEqual(sentiment, 0)
        XCTAssertLessThanOrEqual(sentiment, 1)
    }
    
    func testSentimentWithinRangeWithMediumPrice() {
        let sentiment = coinSentiment(price: 10_000)
        XCTAssertGreaterThanOrEqual(sentiment, 0)
        XCTAssertLessThanOrEqual(sentiment, 1)
    }
    
    func testSentimentWithinRangeWithOutOfRangePrice1() {
        let sentiment = coinSentiment(price: 1_000)
        XCTAssertGreaterThanOrEqual(sentiment, 0)
        XCTAssertLessThanOrEqual(sentiment, 1)
    }
    
    func testSentimentWithinRangeWithOutOfRangePrice2() {
        let sentiment = coinSentiment(price: 20_000)
        XCTAssertGreaterThanOrEqual(sentiment, 0)
        XCTAssertLessThanOrEqual(sentiment, 1)
    }

    func coinSentiment(price: Double) -> Double {
        let trade = Trade(data: Trade.PayloadData(timestamp: "0", price: price), sentiment: 0)
        let sentiment = CoinSentiment()
        return sentiment.sentiment(trade: trade)
    }

}
