//
//  ContentView.swift
//  watchClient Watch App
//
//  Created by 李致中 on 2023/8/28.
//

import SwiftUI

struct ContentView: View {
    @StateObject var socketManger = WebSocketManger()
    @State private var count = 0
    var body: some View {
        if self.socketManger.response != "success" {
            startView
        }
        else {
            loadingView
        }
    }
    
    var startView: some View {
        VStack {
            Text("Press send to start").padding()
            Text("Shoot: \(count)")
            Button("Send") {
                socketManger.send()
                count += 1
            }
        }
        .onAppear {
            socketManger.connect()
        }
    }
    
    var loadingView: some View {
        VStack {
            Text("shooting")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//guard let url = URL(string: "ws://192.168.1.114:7000") else {
//    print("Error")
//    return
//}
//let urlSession = URLSession(configuration: .default)
//var request = URLRequest(url: url)
//request.httpMethod = "POST"
//request.httpBody = "start shooting".data(using: .utf8)
//let webSocketTask = urlSession.webSocketTask(with: request)
//webSocketTask.resume()
//let message = URLSessionWebSocketTask.Message.string("Start shooting")
//webSocketTask.send(message) { error in
//    if let error = error {
//        print("WebSocket could not send message because: \(error)")
//    }
//}
//webSocketTask.receive { result in
//    switch result {
//    case .failure(let error):
//        print("error: \(error)")
//    case .success(let message):
//        switch message {
//        case .string(let text):
//            print("Received string: \(text)")
//        case .data(let data):
//            print("Received data \(data)")
//        }
//    }
//}
