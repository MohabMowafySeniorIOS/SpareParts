//
//  ChatModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 7/5/25.
//

import Foundation
import SwiftUI
import Firebase

struct ChatMessage: Identifiable {
    var id: String { uniqeId }
    var msg: String
    var myId: String
    var sellerId: String
    var time: String
    var uniqeId: String
    var userName: String
}

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var messageText: String = ""

    var My_id: String = "\(AuthService.userData?.user?.id ?? 0)"
    var Worker_id: String = ""
    var User_name: String = "Mohab"
    var Worker_name: String = "mostafa"

    init(workerId: String, workerName: String) {
        self.Worker_id = workerId
        self.Worker_name = workerName
        observeMessages()
    }

    func observeMessages() {
        let databaseRef = Database.database().reference()
        databaseRef.child("companions").observe(.childAdded) { snapshot in
            var message = ChatMessage(msg: "", myId: "", sellerId: "", time: "", uniqeId: "", userName: "")

            for child in snapshot.children {
                guard let snap = child as? DataSnapshot else { continue }

                switch snap.key {
                case "msg": message.msg = snap.value as? String ?? ""
                case "myId": message.myId = snap.value as? String ?? ""
                case "sellerId": message.sellerId = snap.value as? String ?? ""
                case "time": message.time = snap.value as? String ?? ""
                case "uniqeId": message.uniqeId = snap.value as? String ?? ""
                case "userName": message.userName = snap.value as? String ?? ""
                default: break
                }
            }

            if message.myId == self.My_id || message.sellerId == self.My_id {
                DispatchQueue.main.async {
                    self.messages.append(message)
                }
            }
        }
    }

    func sendMessage() {
        guard !messageText.isEmpty else { return }

        let databaseRef = Database.database().reference()
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let chatdate = dateFormatter.string(from: now)
        let timestamp = Int(now.timeIntervalSince1970 * 1000)

        let uniqeId = "\(My_id)_\(Worker_id)_\(timestamp)"
        let msgData: [String: Any] = [
            "msg": messageText,
            "myId": My_id,
            "sellerId": Worker_id,
            "time": chatdate,
            "uniqeId": uniqeId,
            "userName": User_name
        ]

        let historyMy: [String: Any] = [
            "lastMsg": messageText,
            "name": Worker_name,
            "time": chatdate,
            "uniqeId": "\(My_id)_\(Worker_id)"
        ]

        let historyWorker: [String: Any] = [
            "lastMsg": messageText,
            "name": User_name,
            "time": chatdate,
            "uniqeId": "\(Worker_id)_\(My_id)"
        ]

        databaseRef.child("chatHistory").child(My_id).child(Worker_id).setValue(historyMy)
        databaseRef.child("chatHistory").child(Worker_id).child(My_id).setValue(historyWorker)
        databaseRef.child("companions").childByAutoId().setValue(msgData)

        messageText = ""
    }
}



// Usage Example
// ChatView(viewModel: ChatViewModel(workerId: "123", workerName: "Mostafa"))
