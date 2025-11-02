//
//  changePAsswordModel.swift
//  MyAuctions
//
//  Created by Moaaz on 30/06/2025.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI

class ChangePasswordViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var userData: String?
    @Published var isLoading: Bool?
    
    func fetchUsers(urlEndPoint:EndPoints = .reset_password, methodType: HTTPMethod = .post ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<String>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                userData = Model?.data
                
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

