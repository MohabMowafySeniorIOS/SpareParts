//
//  FilterPriceandCityViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/26/25.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class FilterPriceandCityViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var cityModel = [CityModel]()
    @Published var isLoading: Bool?
    
    func getCities(urlEndPoint:EndPoints = .cities, methodType: HTTPMethod = .get ) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[CityModel]>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                print(Model?.data ?? [])
                cityModel = Model?.data ?? []
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


