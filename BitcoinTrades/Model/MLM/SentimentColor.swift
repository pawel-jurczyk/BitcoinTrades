//
//  SentimentColor.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 22/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import UIKit

class SentimentColor {
    private var lastSentiment: Double?
    
    func color(sentiment: Double) -> UIColor? {
        guard let last = lastSentiment else {
            lastSentiment = sentiment
            return nil
        }
        
        let sentimentDifference = sentiment - last
        lastSentiment = sentiment
        
        let difference = abs(1000 * sentimentDifference)
        let saturation = max(0, min(difference, 1))
        let greenHue = 120.0 / 360.0
        let redHue = 0.0 / 360.0
        let hue = sentimentDifference > 0 ? greenHue : redHue
        return UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: 1, alpha: 1)
    }
}
