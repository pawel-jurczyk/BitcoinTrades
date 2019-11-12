//
//  Trade.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 22/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import Foundation

struct Trade: Codable {
    let data: PayloadData
    var sentiment: Double = 0
    
    struct PayloadData: Codable {
        let timestamp: String
        let price: Double
    }
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
