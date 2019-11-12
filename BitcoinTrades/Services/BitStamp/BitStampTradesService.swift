//
//  BitStampTradesService.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 21/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import Foundation
import Starscream

final class BitStampTradesService: TradesService {
    
    private static let BitStampURL = "wss://ws.bitstamp.net"
    
    private var socket: WebSocket? = {
        guard let url = URL(string: BitStampTradesService.BitStampURL) else { return nil }
        return WebSocket(url: url)
    }()
    var newTradeCallback: ((Trade) -> Void)?
    
    func start() {
        socket?.delegate = self
        socket?.connect()
    }
    
    func stop() {
        let unsubscribePayload = BitStampPayload(event: .unsubscribe,
                                                 data: .init(channel: .liveTrades))
        if let unsubscribeData = try? JSONEncoder().encode(unsubscribePayload) {
            socket?.write(data: unsubscribeData)
        }
    }
}

extension BitStampTradesService: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        let subscribePayload = BitStampPayload(event: .subscribe,
                                               data: .init(channel: .liveTrades))
        if let subscriptionData = try? JSONEncoder().encode(subscribePayload) {
            socket.write(data: subscriptionData)
        }
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) { }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        guard let data = text.data(using: .utf8) else { return }
        if let payload = try? JSONDecoder().decode(Trade.self, from: data) {
            newTradeCallback?(payload)
        } else if let payload = try? JSONDecoder().decode(BitStampConfirmation.self, from: data) {
            if payload.event == .unsubscriptionSucceeded {
                socket.disconnect()
            }
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) { }
}
