//
//  TradesService.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 21/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import Foundation

protocol TradesService {
    var newTradeCallback: ((Trade) -> Void)? { get set }
    init()
    func start()
    func stop()
}
