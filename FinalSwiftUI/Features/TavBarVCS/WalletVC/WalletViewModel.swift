//
//  WalletModelView.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/28/25.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class WalletViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var walletModel = [TransactionItem]()
    @Published var isLoading: Bool?
    
    func getTransActions(urlEndPoint:EndPoints = .wallet_transactions, methodType: HTTPMethod = .get  ,type:String,page:String) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)?type=\(type)&page=\(page)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<TransactionsData>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                walletModel = Model?.data?.data ?? []
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
    
    func getBalance(urlEndPoint:EndPoints = .wallet_balance, methodType: HTTPMethod = .get ) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<BalanceData>? , err : String? )in
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
    
    
    func postDeposit(urlEndPoint:EndPoints = .wallet_deposit, methodType: HTTPMethod = .post,parameters : BaseParameters = .init(amount:"",payment_method: "")) {
        // PAramters
//        {
//          "amount": 1000,
//          "payment_method": "credit_card"
//        }
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<DepositData>? , err : String? )in
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
    
    func postWithDraw(urlEndPoint:EndPoints = .wallet_withdraw, methodType: HTTPMethod = .post,parameters : BaseParameters = .init(amount:"",bank_account: "",bank_name: "",account_holder: "")) {
        // PAramters
//      {
//        "amount": 500,
//        "bank_account": "SA0380000000608010167519",
//        "bank_name": "Al Rajhi Bank",
//        "account_holder": "عبدالله محمد"
//      }
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<WithdrawalData>? , err : String? )in
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


