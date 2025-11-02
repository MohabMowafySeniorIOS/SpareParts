//
//  HomeViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/27/25.
//

import Foundation

import Foundation
import Combine
import Alamofire
import SwiftUI
class HomeViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var categoryModel = [GeneralCategory]()
    @Published var isLoading: Bool?
    
    func get_categories(urlEndPoint:EndPoints = .general_categories, methodType: HTTPMethod = .get) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[GeneralCategory]>? , err : String? )in
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
}


