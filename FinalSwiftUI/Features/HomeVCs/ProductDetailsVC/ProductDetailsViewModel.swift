//
//  ProductDetailsViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 7/4/25.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class ProductDetailsViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var auctionModel: ListingDetailsData?
    @Published var isLoading: Bool?
    
    func fetchUsers(urlEndPoint:EndPoints, methodType: HTTPMethod  ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<ListingDetailsData>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                auctionModel = Model?.data
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


