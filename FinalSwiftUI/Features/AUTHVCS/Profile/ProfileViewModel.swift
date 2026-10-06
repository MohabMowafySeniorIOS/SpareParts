//
//  ProfileViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/9/25.
//


import Foundation
import Combine

import SwiftUI
class ProfileViewModel: ObservableObject {
    @Published var userModel: LoginData?
    @Published var state: viewState<LoginData?> = .idle
    
    @Published var countryArray = [CountryData]()
    @Published var cityArray = [CityData]()
    @Published var selectedCcountry: CountryData? = nil
    @Published var selectedCity: CityData? = nil
    
    @ObservedObject var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        _coordinator = ObservedObject(wrappedValue: coordinator)
      
        fetchCountries()
        fetchCities()
    }
    
    func disMiss(){
        coordinator.path.removeLast()
    }
    
    func destoryAttach(id:String,completion: @escaping () -> Void ) {
        let url = "\(hostName)general/attachment/delete/\(id)"
        state = .loading(loading: .progress)
        
       
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .post, parameters:nil) { [weak self] (Model: BaseModel<HomeResponse>? , err : String? )in
            guard let self = self else { return }
            if Model?.status == "success" {
                userModel?.avatar = nil
                self.state = .loaded(data: self.state.data)
                completion()
            } else {
                self.state = .error(err ?? "")
            }
        }
    }
    
    func getProfile(urlEndPoint:EndPoints = .profile, methodType: HTTPMethodType = .get) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url,method: .get,parameters: nil){ [weak self] (Model: BaseModel<LoginData>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                 userModel = Model?.data
                 AuthService.userData?.full_name = userModel?.full_name
                 AuthService.userData?.email = userModel?.email
                 AuthService.userData?.city_name = userModel?.city_name
                 AuthService.userData?.city_id = userModel?.city_id
                 AuthService.userData?.country_name = userModel?.country_name
                 AuthService.userData?.country_id = userModel?.country_id
                 AuthService.userData?.phone = userModel?.phone
                 AuthService.userData?.avatar = userModel?.avatar
                
                 self.applyProfileSelections()
                 state = .loaded(data: Model?.data)
            }else {
                state = .error(err ?? "")
            }
        }
    }

    private func applyProfileSelections() {
        if let cityId = userModel?.city_id {
            selectedCity = cityArray.first { $0.id == cityId }
        }
        if let countryId = userModel?.country_id {
            selectedCcountry = countryArray.first { $0.id == countryId }
        }
    }
    
    func updateProfile(urlEndPoint:EndPoints = .profile, methodType: HTTPMethodType = .post ,parameters : BaseParameters) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url,method: .post, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<LoginData>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                 userModel = Model?.data
                 AuthService.userData?.full_name = userModel?.full_name
                 AuthService.userData?.email = userModel?.email
                 AuthService.userData?.city_name = userModel?.city_name
                 AuthService.userData?.city_id = userModel?.city_id
                 AuthService.userData?.country_name = userModel?.country_name
                 AuthService.userData?.country_id = userModel?.country_id
                 AuthService.userData?.phone = userModel?.phone
                 AuthService.userData?.avatar = userModel?.avatar
                 
                disMiss()
            }else {
                state = .error(err ?? "")
            }
        }
    }
    
    func attachMents(urlEndPoint:EndPoints = .storeAttachMents,file: UIImage?, methodType: HTTPMethodType = .post ,parameters : BaseParameters) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        
        state = .loading(loading: .progress)
        APIClient.shared.uploadMultipartWithAlamofire(urlString: url,file: file, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<LoginData>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                 self.getProfile()
            }else {
                state = .error(err ?? "")
            }
        }
    }
    
    func fetchCountries(urlEndPoint:EndPoints = .countries, methodType: HTTPMethodType = .get) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[CountryData]>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                self.countryArray = Model?.data ?? []
                self.applyProfileSelections()
             }else {
                 state = .error(err ?? "")
             }
        }
    }
    
    func fetchCities(countryId: Int? = nil, urlEndPoint:EndPoints = .cities, methodType: HTTPMethodType = .get) {
        var url = "\(hostName)\(urlEndPoint.rawValue)"
        if let countryId {
            url += "?country_id=\(countryId)"
        }
        
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[CityData]>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                self.cityArray = Model?.data ?? []
                self.applyProfileSelections()
             }else {
                 state = .error(err ?? "")
             }
        }
    }
    
   
}
