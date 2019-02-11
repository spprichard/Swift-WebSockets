//
//  main.swift
//  App
//
//  Created by Steven Prichard on 2/10/19.
//

import App
import Service
import Vapor

do {
    var config = Config.default()
    var env = try Environment.detect()
    var services = Services.default()
    
    try App.configure(&config, &env, &services)
    
    let app = try Application(config: config, environment: env, services: services)
    
    try App.boot(app)
    
    let maxFrameLength: Int = 1 << 19
    let worker = MultiThreadedEventLoopGroup(numberOfThreads: 6)
    
    let ws = try HTTPClient.webSocket(scheme: .wss, hostname: "ws-feed.pro.coinbase.com", maxFrameSize: maxFrameLength, on: worker).wait()

    ws.onText { (ws, text) in
        print("REC: ", text)
    }
    
    ws.onError { (ws, error) in
        print("Error: ", error)
    }
    
//    TODO: Instead of passing the hardcoded string, figure out how to encode this Subscribe type and send that
//    let s = Subscribe()
//    let data = try JSONEncoder().encode(s)
    
    ws.send(text: """
        {"type": "subscribe", "channels" : ["level2"], "product_ids" : ["BTC-USD"]}
    """)
    
    try app.run()
} catch {
    print("Top Level Error: \(error)")
    exit(1)
}
