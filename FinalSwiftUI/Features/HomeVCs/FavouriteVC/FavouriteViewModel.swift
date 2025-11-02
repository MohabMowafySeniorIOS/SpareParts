//
//  FavouriteViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/26/25.
//

import Foundation
import Combine
import Alamofire
import SwiftUI
class FavouriteViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var favouriteModel: FavouriteModel?
    @Published var favouritesData  = [Listing]()
    @Published var isLoading: Bool?
    
    func getFavourite(urlEndPoint:EndPoints = .favorites_listings, methodType: HTTPMethod = .get) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<FavouriteModel>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                favouriteModel = Model?.data
                favouritesData = Model?.data?.listings ?? []
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


