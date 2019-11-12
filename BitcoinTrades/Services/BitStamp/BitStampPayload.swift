//
//  BitStampPayload.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 22/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import Foundation

struct BitStampPayload: Codable {
    let event: Event
    let data: PayloadData
    
    enum Event: String, Codable {
        case subscribe = "bts:subscribe"
        case unsubscribe = "bts:unsubscribe"
    }
    
    struct PayloadData: Codable {
        let channel: Channel
    }
    
    enum Channel: String, Codable {
        case liveTrades = "live_trades_btcusd"
    }
}
