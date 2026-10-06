//
//  OrderDetailsViewModel.swift
//  SpareParts
//
//  Created by Mohamed Elboraey on 10/02/2026.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class OrderDetailsViewModel: ObservableObject {
    @Published var showSheet = false
    @Published var bottomSheetType: BottomSheetType = .cancel
    @Published var state: viewState<OrderDetailsModel> = .idle
    @Published var problemTypes = [OrderType]()
    @Published var cancellationReasons = [CancellationReason]()
    @ObservedObject var coordinator: MainCoordinator
    var orderId: String
    init(coordinator: MainCoordinator, orderId: String) {
        _coordinator = ObservedObject(wrappedValue: coordinator)
        self.orderId = orderId
        getOrderData(orderId: orderId)
        getProblemTypes()
        getCancellationReasons()
    }
    
    
    func showCreateOrder(mainOrderType: CreateOrderType) {
       // self.coordinator.createOrder(mainOrderType: <#T##CreateOrderType#>, specificVendor: <#T##Trader?#>)
    }
    
    func createChat(urlEndPoint:EndPoints = .chats, methodType: HTTPMethodType = .post ,param: BaseParameters) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: param.toDictionary()) { [weak self] (Model: BaseModel<RecieptModel>? , err : String? )in
            guard let self = self else { return }
            if Model?.status == "success" {
               // self.coordinator.showChatView(roomId: "\(data.chatID ?? 0)")
            }else {
                state = .error(err ?? "")
            }
        }
    }
    
    func getProblemTypes(orderStatus: String? = nil) {
        var url = "\(hostName)client/problems/types"
        if let orderStatus, !orderStatus.isEmpty,
           let encodedStatus = orderStatus.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            url += "?order_status=\(encodedStatus)"
        }
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .get, parameters:nil) { [weak self] (Model: BaseModel<[OrderType]>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                let reasons = Model?.data ?? []
                guard let orderStatus, !orderStatus.isEmpty else {
                    self.problemTypes = reasons
                    return
                }
                self.problemTypes = reasons.filter { reason in
                    let supportedStatuses = reason.statuses ?? reason.orderStatus.map { [$0] }
                    guard let supportedStatuses, !supportedStatuses.isEmpty else { return true }
                    return supportedStatuses.contains { $0.caseInsensitiveCompare(orderStatus) == .orderedSame }
                }
            } else {
                self.state = .error(err ?? "")
            }
        }
    }

    func getCancellationReasons() {
        let url = "\(hostName)client/orders/cancellation-reasons"
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .get, parameters: nil) { [weak self] (model: BaseModel<[CancellationReason]>?, err: String?) in
            guard let self = self else { return }
            if model?.status == "success" {
                print(model?.data ?? [])
                self.cancellationReasons = model?.data ?? []
            } else if self.cancellationReasons.isEmpty {
                let message = err ?? model?.message ?? "unknown error"
                print("Failed to load cancellation reasons: \(message)")
            }
        }
    }
    
    
    func getOrderData(orderId: String) {
        let url = "\(hostName)\(EndPoints.orders.rawValue)/\(orderId)"
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .get, parameters:nil) { [weak self] (Model: BaseModel<OrderDetailsModel>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                self.state = .loaded(data: Model?.data)
                self.getProblemTypes(orderStatus: Model?.data?.status?.value)
            } else {
                self.state = .error(err ?? "")
            }
        }
    }
    func recept(urlEndPoint:EndPoints = .orders, methodType: HTTPMethodType = .post, orderId: String) {
        let url = "\(hostName)\(urlEndPoint.rawValue)/\(orderId)/confirm-receipt"
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<RecieptModel>? , err : String? )in
            guard let self = self else { return }
            if Model?.status == "success" {
                getOrderData(orderId: orderId)
                self.bottomSheetType = .rate
                self.showSheet = true
            }else {
                state = .error(err ?? "")
            }
        }
    }
    
    func payMent(urlEndPoint:EndPoints = .orders, methodType: HTTPMethodType = .post, orderId: String) {
        let url = "\(hostName)\(urlEndPoint.rawValue)/\(orderId)/confirm-receipt"
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<String>? , err : String? )in
            guard let self = self else { return }
            if Model?.status == "success" {
                getOrderData(orderId: orderId)
            }else {
                state = .error(err ?? "")
            }
        }
    }
    
    func updateStatus(methodType: HTTPMethodType = .post, urlEndPoint: String) {
        let url = "\(hostName)trader/orders/\(self.orderId)/update-status"
        let parameter = BaseParameters.init(status: urlEndPoint)
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameter.toDictionary()) { [weak self] (Model: BaseModel<String>? , err : String? )in
            guard let self = self else { return }
            if Model?.status == "success" {
                getOrderData(orderId: orderId)
            }else {
                state = .error(err ?? "")
            }
        }
    }
}
