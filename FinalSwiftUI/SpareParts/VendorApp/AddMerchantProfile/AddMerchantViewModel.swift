//
//  AddMerchantViewModel.swift
//  SpareParts
//
//  Created by Mohab on 13/02/2026.
//

import Foundation
import Foundation
import Combine
import SwiftUI

class AddMerchantViewModel: ObservableObject {
    
    @Published var myAddresses = [AddressData]()
    @Published var selectedAddresses: AddressData? = nil
    
    @Published var state: viewState<HomeResponse?> = .idle
    @Published var isFavourit: Bool?
    
    @Published var countryArray = [CountryData]()
    @Published var cityArray = [CityData]()
    @Published var selectedCcountry: CountryData? = nil
    @Published var selectedCity: CityData? = nil
    
    @ObservedObject var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        _coordinator = ObservedObject(wrappedValue: coordinator)
        fetchCountries()
        fetchCities()
        getAddressAgenda()
    }
    
    func showCreateOrder(mainOrderType: CreateOrderType,specificVendor: Trader?) {
        self.coordinator.createOrder(mainOrderType: mainOrderType, specificVendor: specificVendor)
    }
    
    func fetchCountries(urlEndPoint:EndPoints = .countries, methodType: HTTPMethodType = .get) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[CountryData]>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                self.countryArray = Model?.data ?? []
             }else {
                 state = .error(err ?? "")
             }
        }
    }
    
    func fetchCities(urlEndPoint:EndPoints = .cities, methodType: HTTPMethodType = .get) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<[CityData]>? , err : String? )in
            guard let self = self else { return }
             if Model?.status == "success" {
                self.cityArray = Model?.data ?? []
             }else {
                 state = .error(err ?? "")
             }
        }
    }
    
    func getAddressAgenda(urlEndPoint: EndPoints = .client_addresses, methodType: HTTPMethodType = .get) {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        
        APIClient.shared.performRequestWithAlamofire(
            urlString: url, method: methodType, parameters: nil
        ) { [weak self] (Model: BaseModel<[AddressData]>?, err: String?) in
            guard let self = self else { return }
             if Model?.status == "success" {
                myAddresses = Model?.data ?? []
                 
                 
           }else {
               
           }
        }
    }
    
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
        
       
}
