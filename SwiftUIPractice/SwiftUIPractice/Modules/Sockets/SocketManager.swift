//
//  SocketManager.swift
//  SwiftUIPractice
//
//  Created by Кирилл Щёлоков on 15.07.2024.
//

import Foundation

class SocketManager: NSObject {
    private var webSocketTask: URLSessionWebSocketTask?
    private var urlSession: URLSession!

    // Initialization
    override init() {
        super.init()
        urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    }

    // Connect using dynamic parameters
    func connect(signature: String, device: String) {
        let parameters = ["signature": signature, "device": device]
        guard let jsonData = try? JSONEncoder().encode(parameters) else {
            print("Failed to encode parameters.")
            return
        }
        let dataString = String(data: jsonData, encoding: .utf8) ?? ""
        guard let encodedData = dataString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Failed to encode data string as URL component.")
            return
        }

        let urlString = "wss://razrab.nasotku.ru/go/room?data=\(encodedData)"
        guard let url = URL(string: urlString) else {
            print("Failed to create URL.")
            return
        }

        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        receive()
    }

    // Disconnect WebSocket
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }

    // Send a WebRTC signaling request
    func sendRequest(_ request: WebrtcSignalingRequest) {
        guard let jsonData = try? JSONEncoder().encode(request) else {
            print("Failed to encode request.")
            return
        }
        let message = URLSessionWebSocketTask.Message.data(jsonData)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("Error sending message: \(error)")
            }
        }
    }

    // Receive messages from WebSocket
    private func receive() {
        webSocketTask?.receive { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print("WebSocket receive error: \(error)")
            case .success(let message):
                switch message {
                case .data(let data):
                    self.handleResponseData(data)
                case .string(let text):
                    print("Received string message: \(text)")
                @unknown default:
                    fatalError("Received unknown message type from WebSocket.")
                }
            }
            self.receive() // Continue receiving messages
        }
    }

    // Handle received data and decode it
    private func handleResponseData(_ data: Data) {
        guard let response = try? JSONDecoder().decode(WebrtcSignalingResponse.self, from: data) else {
            print("Failed to decode response.")
            return
        }
        // Post a notification with the WebRTC signaling response
        NotificationCenter.default.post(name: .didReceiveWebrtcSignalingResponse, object: response)
    }
}

extension SocketManager: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocket closed with code \(closeCode)")
    }
}

extension Notification.Name {
    static let didReceiveWebrtcSignalingResponse = Notification.Name("didReceiveWebrtcSignalingResponse")
}
