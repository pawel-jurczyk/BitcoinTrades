//
//  TradesTableViewDataSourceTests.swift
//  BitcoinTradesTests
//
//  Created by Pawel Jurczyk on 24/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import XCTest
@testable import BitcoinTrades

class TradesTableViewDataSourceTests: XCTestCase {
    
    func testInitialState() {
        let tradesDataSource = TradesTableViewDataSource()
        let numberOfRows = tradesDataSource.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssert(numberOfRows == 0)
    }

    func testDataSourceReturnsConfiguredCell() {
        let tradesDataSource = TradesTableViewDataSource()
        tradesDataSource.cellModels = [CellModel(text: "test1", detailText: "test2", backgroundColor: .red)]
        let cell = tradesDataSource.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssert(cell.textLabel?.text == "test1")
        XCTAssert(cell.detailTextLabel?.text == "test2")
        XCTAssert(cell.backgroundColor == .red)
        XCTAssert(tradesDataSource.tableView(UITableView(), numberOfRowsInSection: 0) == 1)
    }

}
