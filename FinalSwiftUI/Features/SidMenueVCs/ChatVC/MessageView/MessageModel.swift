//
//  MessageModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 7/5/25.
//

import Foundation
struct RoomModel: Identifiable {
    var id: String { Room_id }
    var Room_id: String = ""
    var lastMsg: String?
    var name: String?
    var time: String?
    var uniqeId: String?
}
