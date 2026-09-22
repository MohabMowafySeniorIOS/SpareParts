//
//  FavouriteViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 6/26/25.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class FavouritsViewModel: ObservableObject {
    @Published var state: viewState<[Trader]?> = .idle
    @Published var traders:[Trader] = []
    @Published var canLoadMore: Bool = false
    private var currentPage = 1
    private var isFetching = false
    private var requestID = UUID()
    @ObservedObject var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        _coordinator = ObservedObject(wrappedValue: coordinator)
        getFavourite()
    }
    
    /// بتتنادى من الـ onAppear بتاع كل كارت، ولما نوصل لآخر عنصر نجيب الصفحة اللي بعدها
    func loadMoreIfNeeded(currentTrader: Trader) {
        guard let last = traders.last,
              currentTrader.id == last.id,
              canLoadMore,
              !isFetching else { return }
        fetchFavourites()
    }
    
    /// بتجيب المفضلة من أول صفحة (أول فتح / الرجوع للتاب / pull to refresh)
    func getFavourite() {
        currentPage = 1
        canLoadMore = false
        isFetching = false
        fetchFavourites()
    }
    
    private func fetchFavourites(urlEndPoint:EndPoints = .favorites, methodType: HTTPMethodType = .get) {
        let page = currentPage
        let url = "\(hostName)\(urlEndPoint.rawValue)?page=\(page)"
        
        isFetching = true
        let thisRequest = UUID()
        requestID = thisRequest
        if page == 1 {
            state = .loading(loading: .progress)
        }
        
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModelPaginate<[Trader]>? , err : String? )in
            guard let self = self else { return }
            // لو حصل refresh والريكوست ده قديم، تجاهله
            guard thisRequest == self.requestID else { return }
            self.isFetching = false
            
            if Model?.status == "success" {
                let newTraders = Model?.data?.data ?? []
                if page == 1 {
                    self.traders = newTraders
                } else {
                    self.traders.append(contentsOf: newTraders)
                }
                
                let lastPage = Model?.data?.lastPage ?? page
                if page < lastPage {
                    self.currentPage = page + 1
                    self.canLoadMore = true
                } else {
                    self.canLoadMore = false
                }
                
                self.state = self.traders.isEmpty ? .emptyScreen : .loaded(data: self.traders)
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
                    guard let index = self.traders.firstIndex(where: { $0.id == traderModel.id }) else { return }
                    self.traders.remove(at: index)
                    self.traders = self.traders
                    if self.traders.count == 0 {
                        self.state = .emptyScreen
                    }
                }
            }else {
                self.state = .error(err ?? "")
            }
            
        }
    }
}
