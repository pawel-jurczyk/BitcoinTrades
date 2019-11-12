//
//  BitStampConfirmation.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 22/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import Foundation

struct BitStampConfirmation: Codable {
    let event: Event
    let channel: Channel
    
    enum Event: String, Codable {
        case subscriptionSucceeded = "bts:subscription_succeeded"
        case unsubscriptionSucceeded = "bts:unsubscription_succeeded"
    }
    
    enum Channel: String, Codable {
        case liveTrades = "live_trades_btcusd"
    }
}
