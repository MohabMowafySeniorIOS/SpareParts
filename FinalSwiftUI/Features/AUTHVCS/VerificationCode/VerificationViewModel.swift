//
//  VerificationModel.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 17/01/2025.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class VerificationViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var activateModel: UserData?
    @Published var resendCodeData: OTPData?
    @Published var isLoading: Bool?
    
    func VerifyAccount(urlEndPoint:EndPoints, methodType: HTTPMethod  ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<UserData>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                self.activateModel = Model?.data
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
    
    
    
    func ResendCode(urlEndPoint:EndPoints, methodType: HTTPMethod,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters:parameters.toDictionary()) { [weak self] (Model: BaseModel<OTPData>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                self.resendCodeData = Model?.data
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

