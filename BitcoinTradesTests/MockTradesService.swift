//
//  MockTradesService.swift
//  BitcoinTradesTests
//
//  Created by Pawel Jurczyk on 23/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import Foundation
@testable import BitcoinTrades

final class MockTradesService: TradesService {
    
    var startWasCalled = false
    var stopWasCalled = false
    
    var onStartCalled: () -> () = { }
    var onStopCalled: () -> () = { }
    
    var newTradeCallback: ((Trade) -> Void)?
    
    func start() {
        startWasCalled = true
        onStartCalled()
    }
    
    func stop() {
        stopWasCalled = true
        onStopCalled()
    }
}
