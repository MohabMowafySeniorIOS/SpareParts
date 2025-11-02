//
//  carAuctionViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 7/2/25.
//


import Foundation
import Combine
import Alamofire
import SwiftUI
class CarAuctionViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var auctionModel = [AuctionItemData]()
    @Published var isLoading: Bool?
    
    func getAuctions(urlEndPoint:EndPoints = .auctions, methodType: HTTPMethod = .get) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[AuctionItemData]>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                auctionModel = Model?.data ?? []
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


