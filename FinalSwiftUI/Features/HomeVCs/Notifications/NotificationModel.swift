//
//  NotificationMode.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/15/25.
//

import Foundation
struct Notification: Identifiable, Codable {
    let id: String
    let message: String
    let time: String
    let date: String
    let isRead: Bool
}
