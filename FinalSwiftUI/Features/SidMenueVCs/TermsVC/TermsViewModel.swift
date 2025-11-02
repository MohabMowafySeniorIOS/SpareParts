//
//  TermsViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/7/25.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class TermsViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var termsModel: TermsData?
    @Published var isLoading: Bool?
    
    func getTerms(urlEndPoint:EndPoints, methodType: HTTPMethod  ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: TermsResponse? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                self.termsModel = Model?.data
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

