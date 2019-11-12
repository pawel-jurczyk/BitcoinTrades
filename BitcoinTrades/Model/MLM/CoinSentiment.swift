//
//  CoinSentiment.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 22/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import CoreML
import Foundation

class CoinSentiment {
    private static let priceRange: (min: Double, max: Double) = (2000, 18000)
    private let sentiment = BitcoinSentiment()
    
    func sentiment(trade: Trade) -> Double {
        let normalizedPrice = max(min(trade.data.price, CoinSentiment.priceRange.max), CoinSentiment.priceRange.min)
        let input = BitcoinSentimentInput(price: normalizedPrice)
        let output = try? sentiment.prediction(input: input)
        return output?.sentiment ?? 0
    }
}

// MARK: Mocked Machine Learning Model

struct BitcoinSentiment {
    func prediction(input: BitcoinSentimentInput) throws -> BitcoinSentimentOutput? {
        return BitcoinSentimentOutput(sentiment: input.price / 10_000)
    }
}

struct BitcoinSentimentInput {
    let price: Double
}

struct BitcoinSentimentOutput {
    let sentiment: Double
}
