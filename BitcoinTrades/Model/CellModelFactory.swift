//
//  CellModelFactory.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 22/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import Foundation

class CellModelFactory {
    
    private let dateFormatter = DateFormatter()
    private let numberFormatter = NumberFormatter()
    private let coinSentiment = CoinSentiment()
    private let sentimentColor = SentimentColor()
    
    init() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "USD"
    }
    
    func cellModel(from trade: Trade) -> CellModel {
        let text = numberFormatter.string(from: NSNumber(value: trade.data.price)) ?? ""
        var detailText: String? = ""
        if let timeInterval = TimeInterval(trade.data.timestamp) {
            let date = Date(timeIntervalSince1970: timeInterval)
            detailText = dateFormatter.string(from: date)
        }
        let sentiment = coinSentiment.sentiment(trade: trade)
        
        let backgroundColor = sentimentColor.color(sentiment: sentiment)
        
        return CellModel(text: text,
                         detailText: detailText,
                         backgroundColor: backgroundColor)
    }
}
