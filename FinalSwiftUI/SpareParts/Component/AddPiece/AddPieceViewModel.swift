//
//  AddPieceViewؤخيثم.swift
//  SpareParts
//
//  Created by Mohab on 14/02/2026.
//

import Foundation
import Combine
import SwiftUI

class AddPieceViewModel: ObservableObject {
    
    @Published var state: viewState<HomeResponse?> = .idle
    @Published var isFavourit: Bool?
    var pickedImages: [AttachMentModel?] = []
   
   
   
    
    func completeProfile(parameters:BaseParameters) {
        let url = "\(hostName)\(EndPoints.completeProfile.rawValue)"
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .post, parameters:parameters.toDictionary()) { [weak self] (Model: BaseModel<HomeResponse>? , err : String? )in
            guard let self = self else { return }
            if Model?.status == "success" {
                self.state = .loaded(data: Model?.data)
            } else {
                self.state = .error(err ?? "")
            }
        }
    }
        
    func attachMents(urlEndPoint:EndPoints = .storeAttachMents,file: UIImage?, methodType: HTTPMethodType = .post ,parameters : BaseParameters) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        
        state = .loading(loading: .progress)
        APIClient.shared.uploadMultipartWithAlamofire(urlString: url,file: file, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<AttachMentModel>? , err : String? )in
            
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                if Model?.status == "success" {
                    self.pickedImages.append(Model?.data)
                    self.state = .loaded(data: self.state.data)
               }else {
                   self.state = .error(err ?? "")
               }
            }
            
        }
    }
}
