//
//  SentimentColorTests.swift
//  BitcoinTradesTests
//
//  Created by Pawel Jurczyk on 23/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import XCTest
@testable import BitcoinTrades

class SentimentColorTests: XCTestCase {
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    
    override func setUp() {
        red = 0
        green = 0
        blue = 0
    }
    
    func testFirstColorIsNil() {
        let sentimentColor = SentimentColor()
        let color = sentimentColor.color(sentiment: 0.5)
        XCTAssertNil(color)
    }
    
    func testSecondSameSentimentIsWhite() {
        let sentimentColor = SentimentColor()
        _ = sentimentColor.color(sentiment: 0.5)
        let color = sentimentColor.color(sentiment: 0.5)
        color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 1)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)
    }
    
    func testSecondHigherSentimentIsGreen() {
        let sentimentColor = SentimentColor()
        _ = sentimentColor.color(sentiment: 0.5)
        let color = sentimentColor.color(sentiment: 0.51)
        color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 0)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 0)
    }
    
    func testSecondLowerSentimentIsRed() {
        let sentimentColor = SentimentColor()
        _ = sentimentColor.color(sentiment: 0.5)
        let color = sentimentColor.color(sentiment: 0.49)
        color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 1)
        XCTAssertEqual(green, 0)
        XCTAssertEqual(blue, 0)
    }
    
    func testSecondSlightlyLowerSentimentIsReddish() {
        let sentimentColor = SentimentColor()
        _ = sentimentColor.color(sentiment: 0.5)
        let color = sentimentColor.color(sentiment: 0.4999)
        color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertEqual(red, 1)
        XCTAssertGreaterThan(green, 0)
        XCTAssertGreaterThan(blue, 0)
    }
    
    func testSecondSlightlyHigherSentimentIsGreenish() {
        let sentimentColor = SentimentColor()
        _ = sentimentColor.color(sentiment: 0.5)
        let color = sentimentColor.color(sentiment: 0.5001)
        color?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssertGreaterThan(red, 0)
        XCTAssertEqual(green, 1)
        XCTAssertGreaterThan(blue, 0)
    }
}
