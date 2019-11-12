//
//  CellModelFactoryTests.swift
//  BitcoinTradesTests
//
//  Created by Pawel Jurczyk on 23/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import XCTest
@testable import BitcoinTrades

class CellModelFactoryTests: XCTestCase {

    func testReturnsValidModelWithoutColor() {
        let factory = CellModelFactory()
        let trade = Trade(data: Trade.PayloadData(timestamp: "1571817113", price: 8132.45), sentiment: 0)
        let model = factory.cellModel(from: trade)
        XCTAssertEqual(model.text, "$8,132.45")
        XCTAssertEqual(model.detailText, "Oct 23, 2019 at 9:51:53 AM")
        XCTAssertNil(model.backgroundColor)
    }

    func testReturnsValidModelWithColor() {
        let factory = CellModelFactory()
        let trade = Trade(data: Trade.PayloadData(timestamp: "1571817113", price: 8132.45), sentiment: 0)
        _ = factory.cellModel(from: trade)
        let model = factory.cellModel(from: trade)
        XCTAssertEqual(model.text, "$8,132.45")
        XCTAssertEqual(model.detailText, "Oct 23, 2019 at 9:51:53 AM")
        XCTAssertNotNil(model.backgroundColor)
    }
}
