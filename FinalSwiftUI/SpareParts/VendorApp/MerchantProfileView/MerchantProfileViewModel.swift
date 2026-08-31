//
//  VendorHomeViewModel.swift
//  SpareParts
//
//  Created by Mohab on 13/02/2026.
//


import Foundation
import Combine
import SwiftUI

class MerchantProfileViewModel: ObservableObject {
    
    @Published var state: viewState<LoginData?> = .idle
    @Published var isFavourit: Bool?
    
    @ObservedObject var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        _coordinator = ObservedObject(wrappedValue: coordinator)
        getProfileData()
    }
    
    func showUpdateFileBusniss(){
        coordinator.showUpdateFileBusniss()
    }
    
    
    func getProfileData() {
        let url = "\(hostName)\(EndPoints.profile)"
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .get, parameters:nil) { [weak self] (Model: BaseModel<LoginData>? , err : String? )in
            guard let self = self else { return }
            if Model?.status == "success" {
                self.state = .loaded(data: Model?.data)
            } else {
                self.state = .error(err ?? "")
            }
        }
    }
        
       
}
