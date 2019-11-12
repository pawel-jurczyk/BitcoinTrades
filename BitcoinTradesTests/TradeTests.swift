//
//  TradeTests.swift
//  BitcoinTradesTests
//
//  Created by Pawel Jurczyk on 24/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import XCTest
@testable import BitcoinTrades

class TradeTests: XCTestCase {

    func testDecodingSample() {
        let tradeString = "{\"data\": {\"microtimestamp\": \"1571911556897978\", \"amount\": 5.0, \"buy_order_id\": 4260283181, \"sell_order_id\": 4260283255, \"amount_str\": \"5.00000000\", \"price_str\": \"7453.54\", \"timestamp\": \"1571911556\", \"price\": 7453.54, \"type\": 1, \"id\": 99205119}, \"event\": \"trade\", \"channel\": \"live_trades_btcusd\"}"
        guard let data = tradeString.data(using: .utf8) else { XCTFail(); return }
        let trade = try? JSONDecoder().decode(Trade.self, from: data)
        XCTAssert(trade?.data.price == 7453.54)
        XCTAssert(trade?.data.timestamp == "1571911556")
    }
}
