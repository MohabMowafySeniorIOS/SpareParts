//
//  MessageViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 7/5/25.
//

import Foundation
import Foundation
import FirebaseDatabase

class MessagesViewModel: ObservableObject {
    @Published var rooms: [RoomModel] = []
    private var my_Id = "\(AuthService.userData?.user?.id ?? 0)"

    init() {
        observeRooms()
    }

    func observeRooms() {
        let ref = Database.database().reference()
        ref.child("chatHistory").child(my_Id).observe(.childAdded) { snapshot in
            var model = RoomModel()
            model.Room_id = snapshot.key

            for child in snapshot.children {
                guard let snap = child as? DataSnapshot else { continue }

                switch snap.key {
                case "lastMsg":
                    model.lastMsg = snap.value as? String
                case "name":
                    model.name = snap.value as? String
                case "time":
                    model.time = snap.value as? String
                case "uniqeId":
                    model.uniqeId = snap.value as? String
                default:
                    break
                }
            }

            DispatchQueue.main.async {
                self.rooms.append(model)
            }
        }
    }
}
