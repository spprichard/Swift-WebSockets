//
//  CoinBase.swift
//  App
//
//  Created by Steven Prichard on 2/10/19.
//

import Foundation

//{"type" : "subscribe", "channels" : ["level2"], "product_ids" : ["BTC-USD"]}
public struct Subscribe: Encodable {
    var type: String = "subscribe"
    var channels: [String] = [
        "level2"
    ]
    var product_ids: [String] = [
        "BTC-USD"
    ]
}
