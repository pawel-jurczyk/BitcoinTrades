//
//  TradesAggregator.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 23/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import Foundation

class TradesAggregator {
    private static let addRESTServiceAfterEach = 100
    private static let amountOfRESTTrades = 25
    
    private var tradesService: TradesService
    private var restTradesService: TradesService
    
    private var serviceSwitchCounter = 0
    private var restServiceSwitchCounter = TradesAggregator.amountOfRESTTrades
    
    var processNewTrade: ((Trade) -> ())?
    
    init(tradeService: TradesService,
         restTradeService: TradesService) {
        self.tradesService = tradeService
        self.restTradesService = restTradeService
    }
    
    func startTradeService() {
        tradesService.newTradeCallback = { trade in
            DispatchQueue.main.async {
                self.increaseCounter()
                self.processNewTrade?(trade)
            }
        }
        tradesService.start()
    }
    
    private func increaseCounter() {
        serviceSwitchCounter += 1
        if serviceSwitchCounter >= TradesAggregator.addRESTServiceAfterEach {
            startAdditionalTradeService()
            serviceSwitchCounter = 0
        }
    }
    
    private func startAdditionalTradeService() {
        restServiceSwitchCounter = TradesAggregator.amountOfRESTTrades
        restTradesService.newTradeCallback = { trade in
            DispatchQueue.main.async {
                self.processAdditionalTradeWithCounter(trade: trade)
            }
        }
        restTradesService.start()
    }
    
    private func processAdditionalTradeWithCounter(trade: Trade) {
        restServiceSwitchCounter -= 1
        if restServiceSwitchCounter >= 0 {
            processNewTrade?(trade)
            if restServiceSwitchCounter == 0 {
                restTradesService.stop()
            }
        }
    }
}
