//
//  RatingsViewModel.swift
//  MyAuctions
//
//  Created by Mohab on 07/07/2025.
//
import Foundation
import Combine

import SwiftUI

class RatingViewModel: ObservableObject {
   
    @Published var ratings: [ratingData]?
    @Published var state: viewState<[ratingData]?> = .idle
    @Published var canLoadMore: Bool = false
    private var currentPage = 1
    private var isFetching = false
    private var requestID = UUID()
    var traderId = ""
    
    init(traderId: String) {
        self.traderId = traderId
        getRatings(traderId: traderId)
    }
    
    /// بتتنادى من الـ onAppear بتاع كل تقييم، ولما نوصل لآخر عنصر نجيب الصفحة اللي بعدها
    func loadMoreIfNeeded(currentItem: ratingData) {
        guard let last = ratings?.last,
              currentItem.id == last.id,
              canLoadMore,
              !isFetching else { return }
        fetchRatings()
    }
    
    /// بتجيب التقييمات من أول صفحة (أول فتح / pull to refresh)
    func getRatings(traderId: String) {
        self.traderId = traderId
        currentPage = 1
        canLoadMore = false
        isFetching = false
        fetchRatings()
    }
    
    func refresh() {
        getRatings(traderId: traderId)
    }
    
    private func fetchRatings(urlEndPoint:EndPoints = .ratings, methodType: HTTPMethodType = .get) {
        let page = currentPage
        let url = "\(hostName)\(urlEndPoint.rawValue)/\(traderId)?page=\(page)"
        
        isFetching = true
        let thisRequest = UUID()
        requestID = thisRequest
        if page == 1 {
            state = .loading(loading: .progress)
        }
        
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters: nil) { [weak self] (Model: BaseModel<RatingCard>? , err : String? )in
            guard let self = self else { return }
            // لو حصل refresh والريكوست ده قديم، تجاهله
            guard thisRequest == self.requestID else { return }
            self.isFetching = false
            
            if Model?.status == "success" {
                let newRatings = Model?.data?.ratings?.data ?? []
                if page == 1 {
                    self.ratings = newRatings
                } else {
                    self.ratings = (self.ratings ?? []) + newRatings
                }
                
                let lastPage = Model?.data?.ratings?.meta?.lastPage ?? page
                if page < lastPage {
                    self.currentPage = page + 1
                    self.canLoadMore = true
                } else {
                    self.canLoadMore = false
                }
                
                if (self.ratings ?? []).isEmpty {
                    self.state = .emptyScreen
                } else {
                    self.state = .loaded(data: self.ratings)
                }
            } else if page == 1 {
                self.state = .error(err ?? "")
            }
            // لو فشلت صفحة غير الأولى بنسيب الداتا اللي ظاهرة زي ما هي
        }
    }
}
