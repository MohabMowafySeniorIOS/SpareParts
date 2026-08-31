//
//  WalletModelView.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/28/25.
//

import Foundation
import Combine

import SwiftUI
class WalletViewModel: ObservableObject {
 
    @Published var walletModel = [TransactionItem]()
    @Published var balanceModel: BalanceData?
    @Published var state: viewState<[TransactionItem]?> = .idle
    @Published var chargeState: viewState<WalletChargeData?> = .idle
    
    @ObservedObject var coordinator: MainCoordinator
    init(coordinator: MainCoordinator){
        _coordinator = ObservedObject(wrappedValue: coordinator)
        getAdditions(page: "1")
        getBalance()
    }
    
    func disMiss(){
        coordinator.path.removeLast()
    }
    
    func getAdditions(urlEndPoint:EndPoints = .WalletChanges, methodType: HTTPMethodType = .get,page:String) {
        var urlEndPoint = urlEndPoint
        var url = "\(hostName)\(urlEndPoint.rawValue)?page=\(page)"
        
        
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<TransactionsData>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                walletModel = Model?.data?.data ?? []
                 state = .loaded(data: Model?.data?.data ?? [])
            }else {
                state = .error(err ?? "")
            }
        }
    }
    
    
    func getTransActions(urlEndPoint:EndPoints = .WalletTransAction, methodType: HTTPMethodType = .get  ,type:String,page:String) {
        var urlEndPoint = urlEndPoint
        var url = "\(hostName)\(urlEndPoint.rawValue)?type=\(type)&page=\(page)"
        if type == "" {
            urlEndPoint = .WalletWithDrawRequest
            url = "\(hostName)\(urlEndPoint.rawValue)?page=\(page)"
        }
        
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<TransactionsData>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                walletModel = Model?.data?.data ?? []
                 state = .loaded(data: Model?.data?.data ?? [])
            }else {
                state = .error(err ?? "")
            }
        }
    }
    
    
    
    func getWithDraw(urlEndPoint:EndPoints = .WalletWithDrawRequest, methodType: HTTPMethodType = .get ,page:String) {
        let url = "\(hostName)\(urlEndPoint.rawValue)?page=\(page)"
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<TransactionsData>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                 walletModel = Model?.data?.data ?? []
                 state = .loaded(data: self.state.data)
            }else {
                state = .error(err ?? "")
            }
        }
    }
    
    func getBalance(urlEndPoint:EndPoints = .WalletBalanace, methodType: HTTPMethodType = .get ) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<BalanceData>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                 balanceModel = Model?.data
             }else {
                 state = .error(err ?? "")
             }
        }
    }
    
    func chargeWallet(urlEndPoint: EndPoints = .ChargeWallet, methodType: HTTPMethodType = .post, amount: Double) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        chargeState = .loading(loading: .progress)
        APIClient.shared.performFormRequestWithAlamofire(
            urlString: url,
            method: methodType,
            parameters: [
                "amount": amount,
                "payment_method": "moyasar",
                "brand": "visa"
            ]
        ) { [weak self] (Model: BaseModel<WalletChargeData>? , err : String? ) in
            guard let self = self else { return }
            if Model?.status == "success" {
                chargeState = .loaded(data: Model?.data)
                if let redirectURL = Model?.data?.redirect_url, !redirectURL.isEmpty {
                    coordinator.showPaymentScreen(url: redirectURL, source: .walletCharge)
                } else {
                    refreshWallet()
                }
            } else {
                chargeState = .error(err ?? "")
            }
        }
    }
    
    func refreshWallet() {
        chargeState = .idle
        getTransActions(type: "deposit", page: "1")
    }
    
    func resetChargeState() {
        chargeState = .idle
    }
 
 
}

struct WalletChargeData: Codable {
    let charge_id: Int?
    let transaction_id: String?
    let redirect_url: String?
    let action: String?
    let payment_method: String?
}
