//
//  AddAdViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/29/25.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class AddAdViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var AdModel: Listing?
    @Published var isLoading: Bool?
    
    func fetchUsers(urlEndPoint:EndPoints, methodType: HTTPMethod  ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<Listing>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                AdModel = Model?.data
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



