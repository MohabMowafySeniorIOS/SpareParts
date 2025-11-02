//
//  AddCustomeAdViewModel.swift
//  MyAuctions
//
//  Created by Mohab on 03/07/2025.
//

import Foundation
import Foundation
import Combine
import Alamofire
import SwiftUI

class AddCustomeAdViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var categoryModel = [CategoryData]()
    @Published var brandModel = [CategoryData]()
    @Published var isLoading: Bool?
    @Published var cityModel = [CategoryData]()
    @Published var listingModel :ListingDetailsData?
    
    @Published var deletionModel :String?
    
    @Published var addFavouriteModel :AddFavouriteModel?
    
    func getCities(urlEndPoint:EndPoints = .cities, methodType: HTTPMethod = .get ) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[CategoryData]>? , err : String? )in
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
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[CategoryData]>? , err : String? )in
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
    
    func createListing(urlEndPoint:EndPoints = .auctions ,images : [UIImage], additional_images : [UIImage] ,parameters : BaseParameters) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)"
        isLoading = true
        APIClient.shared.uploadMultipartWithAlamofire(urlString: url,images: images.first ?? UIImage(), additional_images: additional_images, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<ListingDetailsData>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                listingModel = Model?.data
                
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
    
    func request_deletion(urlEndPoint:EndPoints = .listings , methodType: HTTPMethod = .post , Ad_id : String) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)\(Ad_id)/request-deletion"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<String>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                deletionModel = Model?.data ?? ""
                
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
    
    func Faourite_listings(urlEndPoint:EndPoints = .listings , methodType: HTTPMethod = .post , Ad_id : String) {
        let url = "\(hostName)/\(urlEndPoint.rawValue)/\(Ad_id)/favorite"
        isLoading = true
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<AddFavouriteModel>? , err : String? )in
            guard let self = self else { return }
            if Model != nil {
                addFavouriteModel = Model?.data 
                
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

