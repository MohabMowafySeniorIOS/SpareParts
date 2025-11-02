//
//  RatingsViewModel.swift
//  MyAuctions
//
//  Created by Moaaz on 07/07/2025.
//
import Foundation
import Combine
import Alamofire
import SwiftUI

class RatingViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var ratingModel: RatingCard?
    @Published var isLoading: Bool?
    @Published var ratings: [RatingCard] = [
        RatingCard(
            date: "15/2/205", time: "م 12:30", userName: "إبراهيم محمود",
            rating: 4.5, ratingText: "مستوى التقييم",
            reviewText:
                "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة. لقد تم توليد هذا النص من مولد النص العربي، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التي يولدها التطبيق"
        ),
        RatingCard(
            date: "15/2/205", time: "م 12:30", userName: "إبراهيم محمود",
            rating: 4.5, ratingText: "مستوى التقييم",
            reviewText:
                "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة. لقد تم توليد هذا النص من مولد النص العربي، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التي يولدها التطبيق"
        ),
        RatingCard(
            date: "15/2/205", time: "م 12:30", userName: "إبراهيم محمود",
            rating: 4.5, ratingText: "مستوى التقييم",
            reviewText:
                "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة. لقد تم توليد هذا النص من مولد النص العربي، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التي يولدها التطبيق"
        ),
    ]
    
    func RatingViewModel(urlEndPoint:EndPoints, methodType: HTTPMethod  ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<String>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
//                <#modelName#> = Model?.data
                
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


