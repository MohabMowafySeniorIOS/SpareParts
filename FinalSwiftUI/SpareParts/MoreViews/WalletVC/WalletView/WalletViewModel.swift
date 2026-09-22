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
    
    @Published var canLoadMore: Bool = false
    private var currentPage = 1
    private var isFetching = false
    private var requestID = UUID()
    /// بيبني الـ URL للتاب المفتوح حاليًا حسب رقم الصفحة
    private var currentURLBuilder: ((Int) -> String)?
    
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
        startPaging(from: page, methodType: methodType) { page in
            "\(hostName)\(urlEndPoint.rawValue)?page=\(page)"
        }
    }
    
    func getTransActions(urlEndPoint:EndPoints = .WalletTransAction, methodType: HTTPMethodType = .get  ,type:String,page:String) {
        startPaging(from: page, methodType: methodType) { page in
            if type == "" {
                return "\(hostName)\(EndPoints.WalletWithDrawRequest.rawValue)?page=\(page)"
            }
            return "\(hostName)\(urlEndPoint.rawValue)?type=\(type)&page=\(page)"
        }
    }
    
    func getWithDraw(urlEndPoint:EndPoints = .WalletWithDrawRequest, methodType: HTTPMethodType = .get ,page:String) {
        startPaging(from: page, methodType: methodType) { page in
            "\(hostName)\(urlEndPoint.rawValue)?page=\(page)"
        }
    }
    
    /// بتتنادى من الـ onAppear بتاع كل عنصر، ولما نوصل لآخر عنصر نجيب الصفحة اللي بعدها
    func loadMoreIfNeeded(currentIndex: Int) {
        guard currentIndex == walletModel.count - 1,
              canLoadMore,
              !isFetching else { return }
        fetchTransactions()
    }
    
    /// أي تاب بيتفتح بيبدأ من الصفحة اللي اتبعتت (عادةً "1")
    private func startPaging(from page: String, methodType: HTTPMethodType, urlBuilder: @escaping (Int) -> String) {
        currentURLBuilder = urlBuilder
        currentPage = Int(page) ?? 1
        canLoadMore = false
        isFetching = false
        if currentPage == 1 {
            walletModel = []
        }
        fetchTransactions(methodType: methodType)
    }
    
    private func fetchTransactions(methodType: HTTPMethodType = .get) {
        guard let urlBuilder = currentURLBuilder else { return }
        let page = currentPage
        let url = urlBuilder(page)
        
        isFetching = true
        let thisRequest = UUID()
        requestID = thisRequest
        if page == 1 {
            state = .loading(loading: .progress)
        }
        
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<TransactionsData>? , err : String? )in
            guard let self = self else { return }
            // لو المستخدم غيّر التاب والريكوست ده قديم، تجاهله
            guard thisRequest == self.requestID else { return }
            self.isFetching = false
            
            if Model?.status == "success" {
                let newItems = Model?.data?.data ?? []
                if page == 1 {
                    self.walletModel = newItems
                } else {
                    self.walletModel.append(contentsOf: newItems)
                }
                
                // لو السيرفر مش راجع meta بنعتبرها صفحة واحدة
                let lastPage = Model?.data?.meta?.lastPage ?? page
                if page < lastPage {
                    self.currentPage = page + 1
                    self.canLoadMore = true
                } else {
                    self.canLoadMore = false
                }
                
                self.state = .loaded(data: self.walletModel)
            } else if page == 1 {
                self.state = .error(err ?? "")
            }
            // لو فشلت صفحة غير الأولى بنسيب الداتا اللي ظاهرة زي ما هي
        }
    }
    
    func getBalance(urlEndPoint:EndPoints = .WalletBalanace, methodType: HTTPMethodType = .get ) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
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
