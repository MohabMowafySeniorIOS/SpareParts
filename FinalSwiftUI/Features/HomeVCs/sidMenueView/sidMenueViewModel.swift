//
//  sidMenueViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/26/25.
//


import Foundation
import Combine
import Alamofire
import SwiftUI

class sidMenueViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var logOutModel: String?
    @Published var isLoading: Bool?
    
    func logOut(urlEndPoint:EndPoints = .logout, methodType: HTTPMethod = .post) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<String>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                logOutModel = Model?.data ?? ""
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
    
    func DeleteAccount(urlEndPoint:EndPoints = .account_request_deletion, methodType: HTTPMethod = .post) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<String>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                logOutModel = Model?.data ?? ""
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

