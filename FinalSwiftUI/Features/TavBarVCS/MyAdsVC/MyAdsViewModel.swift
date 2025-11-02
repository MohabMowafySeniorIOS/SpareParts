//
//  MyAdsViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/29/25.
//

import Foundation

import Foundation
import Combine
import Alamofire
import SwiftUI
class MyAdsViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var myAdsModel = [Listing]()
    @Published var isLoading: Bool?
    
    func get_my_listings(urlEndPoint:EndPoints = .my_listings, methodType: HTTPMethod = .get) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<FavouriteModel>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                myAdsModel = Model?.data?.listings ?? []
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


