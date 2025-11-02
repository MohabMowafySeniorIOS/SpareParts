//
//  NotificationViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/15/25.
//

import Foundation
import SwiftUI
import Alamofire
class NotificationsViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var notifications: [Notification] = []
    @Published var isLoading: Bool = false
    
    func fetchNotifications() {
        let url = "\(hostName)/\(EndPoints.notifications.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .get, parameters: nil) { [weak self] (Model: BaseModel<[Notification]>? , err : String? )in
            guard let self = self else { return }
            if let notifications = Model?.data {
                self.notifications = notifications
            } else {
                self.errorMessage = err
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.errorMessage = nil
                    }
                }
            }
            self.isLoading = false
        }
    }
    
    func markAllAsRead() {
        let url = "\(hostName)/\(EndPoints.notifications_read_all.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .get, parameters: nil) { [weak self] (Model: BaseModel<[Notification]>? , err : String? )in
            guard let self = self else { return }
            if let notifications = Model?.data {
                self.notifications = notifications
            } else {
                self.errorMessage = err
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.errorMessage = nil
                    }
                }
            }
            self.isLoading = false
        }
    }
    
    func markNotificationAsREad(urlEndPoint:EndPoints = .notifications, methodType: HTTPMethod = .post  ,notification_id : String) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)\(notification_id)/read"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<LoginData>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
               
                
           }else {
            self.errorMessage = err
               DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                  withAnimation {
                       self.errorMessage = nil
                   }
               }
           }
            self.isLoading = false
        }
    }
    
    func getUnReadNotificationCount(urlEndPoint:EndPoints = .notifications_unread_count, methodType: HTTPMethod = .post  ,notification_id : String) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)\(notification_id)/read"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<UnreadNotificationsData>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
               
                
           }else {
            self.errorMessage = err
               DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                  withAnimation {
                       self.errorMessage = nil
                   }
               }
           }
            self.isLoading = false
        }
    }
}
