//
//  PaymentWebView.swift
//  SpareParts
//
//  Created by Mohab on 20/02/2026.
//

import Foundation
import Combine
import SwiftUI

final class PaymentWebViewModel: ObservableObject {
    
    @Published var state: viewState<LoginData?> = .idle
    
    let coordinator: MainCoordinator
    let source: PaymentSource
    
    init(coordinator: MainCoordinator, source: PaymentSource = .order) {
        self.coordinator = coordinator
        self.source = source
    }
    
    func paymentSuccess(){
        switch source {
        case .order:
            coordinator.path.removeLast(coordinator.path.count-1)
        case .walletCharge:
            coordinator.disMiss()
            NotificationCenter.default.post(name: Foundation.Notification.Name.walletNeedsRefresh, object: nil)
        }
    }
    
    func paymentFailed() {
        switch source {
        case .order:
            paymentSuccess()
        case .walletCharge:
            coordinator.disMiss()
        }
    }
     
   
}

extension Foundation.Notification.Name {
    static let walletNeedsRefresh = Foundation.Notification.Name("walletNeedsRefresh")
}
