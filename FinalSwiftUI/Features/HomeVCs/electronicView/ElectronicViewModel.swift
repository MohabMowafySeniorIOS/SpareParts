//
//  ElectronicViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/27/25.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class ElectronicViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var electronicModel = [Listing]()
    @Published var isLoading: Bool?
    
    func getDate(urlEndPoint:EndPoints = .listings, methodType: HTTPMethod = .get  ,search:String,city_id:String,general_category_id:String,price_from:String,price_to:String,order_by:String,order_direction:String,page:String) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)?search=\(search)&city_id=\(city_id)&general_category_id=\(general_category_id)&price_from=\(price_from)&price_to=\(price_to)&order_by=\(order_by)&order_direction=\(order_direction)&page=\(page)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[Listing]>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                electronicModel = Model?.data ?? []
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


