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
    @ObservedObject var coordinator: MainCoordinator
    var orderId: String
    init(coordinator: MainCoordinator, orderId: String) {
        _coordinator = ObservedObject(wrappedValue: coordinator)
        self.orderId = orderId
        getOrderData(orderId: orderId)
        getProblemTypes()
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
    
    func getProblemTypes() {
        let url = "\(hostName)client/problems/types"
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .get, parameters:nil) { [weak self] (Model: BaseModel<[OrderType]>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                self.state = .loaded(data: self.state.data)
                self.problemTypes = Model?.data ?? []
            } else {
                self.state = .error(err ?? "")
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
