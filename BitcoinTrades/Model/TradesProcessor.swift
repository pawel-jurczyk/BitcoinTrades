//
//  TradesProcessor.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 22/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import Foundation

class TradesProcessor {
    private static let dumpTradesAfterEach = 1000
    
    private var accumulator = [Trade]()
    private let cellModelFactory = CellModelFactory()
    private var tradesAggregator: TradesAggregator
    
    var onDumpCellModels: (() -> ())?
    var onFinishedProcessingCellModels: ((Int, @escaping () -> ()) -> ())?
    var tableViewDataSource = TradesTableViewDataSource() {
        didSet {
            tableViewDataSource.cellModels.reserveCapacity(TradesProcessor.dumpTradesAfterEach)
        }
    }
    
    init(tradesAggregator: TradesAggregator) {
        self.tradesAggregator = tradesAggregator
    }
    
    func startTradeService() {
        tradesAggregator.processNewTrade = processNewTrade(trade:)
        tradesAggregator.startTradeService()
    }
    
    private func processNewTrade(trade: Trade) {
        accumulator.append(trade)
        if accumulator.count == 1 {
            processAccumulator()
        }
    }
    
    private func processAccumulator() {
        guard !accumulator.isEmpty else { return }
        if tableViewDataSource.cellModels.count >= TradesProcessor.dumpTradesAfterEach {
            for model in tableViewDataSource.cellModels.prefix(upTo: TradesProcessor.dumpTradesAfterEach) {
                print(model)
            }
            tableViewDataSource.cellModels.removeFirst(TradesProcessor.dumpTradesAfterEach)
            onDumpCellModels?()
            processAccumulator()
            return
        }

        let accumulatedModels = accumulator.map(cellModelFactory.cellModel)
        tableViewDataSource.cellModels.append(contentsOf: accumulatedModels)
        accumulator.removeAll()
        
        onFinishedProcessingCellModels?(accumulatedModels.count, processAccumulator)
    }
}
