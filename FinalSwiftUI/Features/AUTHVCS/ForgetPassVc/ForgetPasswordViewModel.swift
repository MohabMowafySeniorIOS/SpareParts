//
//  ForgetPasswordViewModel.swift
//  MyAuctions
//
//  Created by Mohab on 07/06/2025.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class ForgetPasswordViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var Model: ResendOTPModel?
    @Published var isLoading: Bool?
    
    func forgotPass(urlEndPoint:EndPoints, methodType: HTTPMethod  ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<ResendOTPModel>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                self.Model = Model?.data
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

