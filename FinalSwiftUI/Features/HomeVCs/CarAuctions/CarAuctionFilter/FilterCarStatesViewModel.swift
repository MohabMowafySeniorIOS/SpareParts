//
//  FilterCarStatesViewModel.swift
//  MyAuctions
//
//  Created by Mohab on 03/07/2025.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI

class FilterCarStatesViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var categoryModel = [CategoryData]()
    @Published var brandModel = [BrandData]()
    @Published var isLoading: Bool?
    
    func getCategories(urlEndPoint:EndPoints = .categories , methodType: HTTPMethod = .get) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[CategoryData]>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                categoryModel = Model?.data ?? []
                
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
    
    func getBrands(urlEndPoint:EndPoints = .brands , methodType: HTTPMethod = .get ) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[BrandData]>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                brandModel = Model?.data ?? []
                
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


