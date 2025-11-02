//
//  contactUsViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/8/25.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class contactUsViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var contactModel: contactUsModel?
    @Published var isLoading: Bool?
    
    func sendMessage(urlEndPoint:EndPoints = .contact_us, methodType: HTTPMethod = .post ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model:contactUsModel? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                contactModel = Model
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


