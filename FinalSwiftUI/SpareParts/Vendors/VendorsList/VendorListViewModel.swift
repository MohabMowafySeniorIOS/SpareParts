//
//  VendorListViewModel.swift
//  SpareParts
//
//  Created by Mohab on 16/02/2026.
//

import Foundation
import SwiftUI
import Combine

class VendorListViewModel: ObservableObject {
    @Published var fieldText: String = ""
    @ObservedObject var locationManager: LocationManager
    @Published var filterObject: FilterObject = FilterObject()
    @Published  var countryAndCities: [CountryAndCitiesModel] = []
    @Published var vendorData: [Trader] = []
    @Published var state: viewState<BaseModel<String>> = .idle
    var canLoadMore: Bool = false
    private var currentPage = 1
    private var isFetching = false
    private var requestID = UUID()
    @ObservedObject var coordinator: MainCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: MainCoordinator, locationManager: LocationManager) {
        _coordinator = ObservedObject(wrappedValue: coordinator)
        self.locationManager = locationManager
        observeSearch()
    }
    
    /// بيتعمل subscribe مرة واحدة بس (من الـ init)
    /// أي تغيير في الفلتر أو الدولة/المدينة يرجّع الليستة من أول صفحة
    func observeSearch() {
        guard cancellables.isEmpty else { return }
        Publishers.CombineLatest($countryAndCities, $filterObject)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _, _ in
                self?.refresh()
            }
            .store(in: &cancellables)
    }
    
    /// يبدأ من أول صفحة (سيرش / فلتر / pull to refresh)
    func refresh() {
        currentPage = 1
        canLoadMore = false
        isFetching = false
        getVendorsData()
    }
    
    /// بتتنادى من الـ onAppear بتاع كل كارت، ولما نوصل لآخر عنصر نجيب الصفحة اللي بعدها
    func loadMoreIfNeeded(currentVendor: Trader) {
        guard let last = vendorData.last,
              currentVendor.id == last.id,
              canLoadMore,
              !isFetching else { return }
        getVendorsData()
    }
    
    func openGoogleMaps(lat: Double, lng: Double) {
        let urlString = "comgooglemaps://?q=\(lat),\(lng)&zoom=14"
        
        if let url = URL(string: urlString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // fallback to browser if Google Maps not installed
            let webURL = "https://maps.google.com/?q=\(lat),\(lng)"
            UIApplication.shared.open(URL(string: webURL)!)
        }
    }
    
    func getVendorsData() {
        var countryId = ""
        var cityId = ""
        if !countryAndCities.isEmpty {
            countryId = "\(countryAndCities.last?.country?.id ?? 0)"
            if let cities = countryAndCities.last?.cities {
                if !cities.isEmpty {
                    cityId = "\(cities.last?.id ?? 0)"
                }
            }
        }
        var latitude = ""
        var longtiude = ""
        var orderBy = ""
        
        if let lat = locationManager.latitude,
           let lon = locationManager.longitude {
            latitude = "\(lat)"
            longtiude = "\(lon)"
            
        } else {
            print("Getting location...")
        }
        
        if filterObject.orderBy == .nearest {
            orderBy = "nearest"
       }
       
        
        if filterObject.orderBy == .newest {
            orderBy = "newest"
        }
        
        
        
        if filterObject.orderBy == .rating  {
            orderBy = "rating"
        }
        
        let keyword = fieldText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let page = currentPage
        let url = "\(hostName)\(EndPoints.vendorsList.rawValue)?keyword=\(keyword)&country_id=\(countryId)&city_id=\(cityId)&order_by=\(orderBy)&latitude=\(latitude)&longitude=\(longtiude)&page=\(page)"
        print(url)
        
        isFetching = true
        let thisRequest = UUID()
        requestID = thisRequest
        if page == 1 {
            state = .loading(loading: .progress)
        }
        
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .get, parameters:nil) { [weak self] (Model: BaseModel<TradersResponse>? , err : String? )in
            
            guard let self = self else { return }
            // لو حصل refresh والريكوست ده قديم، تجاهله
            guard thisRequest == self.requestID else { return }
            self.isFetching = false
            
            if Model?.status == "success" {
                let newVendors = Model?.data?.data ?? []
                if page == 1 {
                    self.vendorData = newVendors
                } else {
                    self.vendorData.append(contentsOf: newVendors)
                }
                
                let lastPage = Model?.data?.meta?.lastPage ?? page
                if page < lastPage {
                    self.currentPage = page + 1
                    self.canLoadMore = true
                } else {
                    self.canLoadMore = false
                }
                
                self.state = self.vendorData.isEmpty ? .emptyScreen : .loaded(data: nil)
            } else if page == 1 {
                self.state = .error(err ?? "")
            }
            // لو فشلت صفحة غير الأولى بنسيب الداتا اللي ظاهرة زي ما هي
        }
    }
    
    func handleFavourite(traderModel: Trader) {
        
        let url = "\(hostName)\(EndPoints.vendorDetails.rawValue)\(traderModel.id)/favorite"
        
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .post, parameters: ["trader": "\(traderModel.id)"]) { [weak self] (Model: BaseModel<IsFavouriteModel>? , err : String? )in
            guard let self = self else { return }
            if Model?.status == "success" {
                DispatchQueue.main.async {
                    guard let index = self.vendorData.firstIndex(where: { $0.id == traderModel.id }) else { return }
                    self.vendorData[index].isFavorite.toggle()
                    self.vendorData = self.vendorData
                }
            }else {
                self.state = .error(err ?? "")
            }
            
        }
    }
    
}
