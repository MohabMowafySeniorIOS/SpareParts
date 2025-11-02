//
//  CreaeOrderViewModel.swift
//  MyAuctions
//
//  Created by Moaaz on 14/07/2025.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI

class CreateOrderViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published  var cars: [Car] = [
        Car(name: "toyota", isSelected: false),
        Car(name: "toyota", isSelected: false),
        Car(name: "toyota", isSelected: false),
    ]
    @Published  var parts: [Part] = [
        Part(name: "any", number: "12", count: "50", type: "new"),
        Part(name: "any", number: "12", count: "50", type: "new"),
        Part(name: "any", number: "12", count: "50", type: "new"),
        Part(name: "any", number: "12", count: "50", type: "new"),
    ]
    @Published  var addedAddress: [AddedAddressModel] = [
        AddedAddressModel(address: "egypt,dakhlya,mansoura,torel", isSelected: false),
        AddedAddressModel(address: "egypt,dakhlya,mansoura,torel", isSelected: false),
        AddedAddressModel(address: "egypt,dakhlya,mansoura,torel", isSelected: false)
    ]
    @Published var isLoading: Bool?
    
    func CreateOrder(urlEndPoint:EndPoints, methodType: HTTPMethod  ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<String>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
            //    <#modelName#> = Model?.data
                
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


