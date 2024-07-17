//
//  SocketView.swift
//  SwiftUIPractice
//
//  Created by Кирилл Щёлоков on 15.07.2024.
//

import SwiftUI

struct SocketView: View {
    var socketManager: SocketManager = SocketManager()
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                let request: MainRequestClass = MainRequestClass()
                request.device = "1"
                request.make_signature(nasotku_token: "1234567890")
                socketManager.connect(signature:                 request.signature, device: "1")
//                socketManager.sendRequest(request)
            }
    }
}

#Preview {
    SocketView()
}
