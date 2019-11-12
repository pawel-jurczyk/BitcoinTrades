//
//  TradesTableViewController.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 21/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import UIKit

class TradesTableViewController: UITableViewController {
    
    let tradesProcessor: TradesProcessor = {
        let tradesAggregator = TradesAggregator(tradeService: BitStampTradesService(),
                                                restTradeService: RESTTradesService())
        return TradesProcessor(tradesAggregator: tradesAggregator)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tradesProcessor.onDumpCellModels = didDumpCellModels
        tradesProcessor.onFinishedProcessingCellModels = didFinishProcessingCellModels
        tableView.dataSource = tradesProcessor.tableViewDataSource
        tradesProcessor.startTradeService()
    }
    
    func didDumpCellModels() {
        tableView.reloadData()
    }
    
    func didFinishProcessingCellModels(count: Int, completion: @escaping () -> ()) {
        guard count > 0 else { return }
        let rows = (0...count - 1).map { IndexPath(row: $0, section: 0) }
        tableView?.performBatchUpdates({
            tableView?.insertRows(at: rows, with: .automatic)
        }, completion: { _ in
            completion()
        })
    }
}
