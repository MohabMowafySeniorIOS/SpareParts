//
//  ProfileViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/9/25.
//


import Foundation
import Combine
import Alamofire
import SwiftUI
class ProfileViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var userModel: UserData?
    @Published var isLoading: Bool?
    
    func updateProfile(urlEndPoint:EndPoints = .profile, methodType: HTTPMethod = .post,profile_image : UIImage? ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.uploadMultipartWithAlamofire(urlString: url,profile_image: profile_image, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<UserData>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                userModel = Model?.data
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


