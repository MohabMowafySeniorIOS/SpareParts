//
//  RatingsMenuViewModel.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 16/07/2025.
//

import Foundation


import Foundation
import Combine
import Alamofire
import SwiftUI
class RatingsMenuViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var RatingsMenuViewModel: String?
    @Published var isLoading: Bool?
    
    func getRatingsMenuData(urlEndPoint:EndPoints, methodType: HTTPMethod) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<String>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                RatingsMenuViewModel = Model?.data
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

