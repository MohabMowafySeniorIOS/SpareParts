//
//  CarDetailsAsTextViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 7/4/25.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI
class CarDetailsAsTextViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var carModel: UserData?
    @Published var isLoading: Bool?
    
    func fetchUsers(urlEndPoint:EndPoints, methodType: HTTPMethod  ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<UserData>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                carModel = Model?.data
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


struct DetailsBar: View {
    
    var title: String
    var des: String
    
    var body: some View {
        HStack{
            Text(title.localized)
            Spacer()
            Text(des.localized)
        }
        .padding(13)
        .background(.cGray3)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
