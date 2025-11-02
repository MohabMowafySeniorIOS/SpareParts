//
//  FAQViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/8/25.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class FAQViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var ModelFAQ: FAQData?
    @Published var isLoading: Bool?
    
    func getFAQS(urlEndPoint:EndPoints, methodType: HTTPMethod ) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters:nil) { [weak self] (Model: BaseModel<FAQData>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                ModelFAQ = Model?.data
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

