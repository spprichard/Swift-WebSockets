import App
import Vapor

public struct Subscribe: Encodable {
    var type: String = "subscribe"
    var channels: [String] = [
        "level2"
    ]
    var product_ids: [String] = [
        "BTC-USD"
    ]
}


let worker = MultiThreadedEventLoopGroup(numberOfThreads: 2)

let coinBaseWS = try HTTPClient.webSocket(
    scheme: HTTPScheme.wss,
    hostname: "ws-feed.pro.coinbase.com",
    on: worker
).wait()

let s = Subscribe()
let jsonData = try JSONEncoder().encode(s)
let rawStr = String(bytes: jsonData, encoding: .utf8)

coinBaseWS.send(String(rawStr!))


coinBaseWS.onText({ws, text in
    print("coinBase REC: ", text)
})

coinBaseWS.onBinary({ws, text in
    print(text)
})


try app(.detect()).run()
