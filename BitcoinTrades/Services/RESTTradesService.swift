//
//  RESTTradesService.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 22/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import Foundation

final class RESTTradesService: TradesService {

    private static let numberOfGeneratedTrades = 50
    private var isRunning = false
    private var trades: [Trade] = []
    private let queue = DispatchQueue.global()
    
    var newTradeCallback: ((Trade) -> Void)?
    
    func start() {
        trades = (0...RESTTradesService.numberOfGeneratedTrades).map {
            Trade(data: Trade.PayloadData(timestamp: "1571750844",
                                          price: Double($0) + 8200.0),
                  sentiment: 0.37)
        }
        queue.async {
            self.isRunning = true
            self.sendNewTrade()
        }
    }
    
    private func sendNewTrade() {
        guard isRunning else { return }
        let numberOfTrades = min(Int.random(in: 0 ..< 3), trades.count)
        let tradesSuffix = trades.suffix(numberOfTrades)
        trades.removeLast(numberOfTrades)
        queue.asyncAfter(deadline: .now() + 1) {
            for trade in tradesSuffix {
                self.newTradeCallback?(trade)
            }
            self.sendNewTrade()
        }
    }
    
    func stop() {
        queue.async {
            self.isRunning = false
        }
    }
}
