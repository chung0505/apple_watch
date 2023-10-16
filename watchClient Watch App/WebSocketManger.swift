//
//  WebSocketManger.swift
//  watchClient Watch App
//
//  Created by 李致中 on 2023/8/28.
//

import Foundation

class WebSocketManger: ObservableObject {
    @Published var response = ""
    
    private var socketTask: URLSessionWebSocketTask?

    func connect() {
        if let url = URL(string: "ws://127.0.0.1:7000") {
            let session = URLSession(configuration: .default)
            socketTask = session.webSocketTask(with: url)
            listen()
            socketTask?.resume()
        } else {
            print("invalid URL")
        }
    }
    
    func send() {
        if let task = socketTask {
            let message = URLSessionWebSocketTask.Message.string("start shoot")
            task.send(message) { error in
                   if let error = error {
                       print("Error sending message: \(error)")
                   } else {
                       print("Sent \(message)")
                   }
            }
        }
    }
    
    private func listen() {
        if let task = socketTask {
            task.receive { result in
                switch result {
                case .success(let message):
                    switch message {
                    case .string(let text):
                        DispatchQueue.main.async {
                            self.response = text
                            self.listen()
                            print("get \(text)")
                        }
                    default:
                        print("Received non-string message.")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
                
            }
        }
    }
}


