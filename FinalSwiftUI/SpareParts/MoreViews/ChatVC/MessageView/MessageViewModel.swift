//
//  MessageViewModel.swift
//  MyAuctions
//
//  Created by مهاب موافي on 7/5/25.
//

import Foundation
import Combine
import SwiftUI


class MessagesViewModel: ObservableObject {
    @Published var rooms: [MessagesModel] = []
    private var my_Id = "\(AuthService.userData?.id ?? "0")"
    @Published var state: viewState<[MessagesModel]?> = .idle
    @Published var canLoadMore: Bool = false
    private var currentPage = 1
    private var isFetching = false
    private var requestID = UUID()
    @ObservedObject var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        _coordinator = ObservedObject(wrappedValue: coordinator)
        getChats()
    }
    
    func disMiss(){
        coordinator.path.removeLast()
    }
    
    /// بتتنادى من الـ onAppear بتاع كل محادثة، ولما نوصل لآخر عنصر نجيب الصفحة اللي بعدها
    func loadMoreIfNeeded(currentRoom: MessagesModel) {
        guard let last = rooms.last,
              currentRoom.id == last.id,
              canLoadMore,
              !isFetching else { return }
        fetchChats()
    }

    /// بتجيب المحادثات من أول صفحة (أول فتح / pull to refresh)
    func getChats() {
        currentPage = 1
        canLoadMore = false
        isFetching = false
        fetchChats()
    }
    
    private func fetchChats(urlEndPoint:EndPoints = .chats, methodType: HTTPMethodType = .get ) {
        let page = currentPage
        let url = "\(hostName)\(urlEndPoint.rawValue)?page=\(page)"
        
        isFetching = true
        let thisRequest = UUID()
        requestID = thisRequest
        if page == 1 {
            state = .loading(loading: .progress)
        }
        
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: methodType, parameters:nil) { [weak self] (Model: BaseModelPaginate<[MessagesModel]>? , err : String? )in
            guard let self = self else { return }
            // لو حصل refresh والريكوست ده قديم، تجاهله
            guard thisRequest == self.requestID else { return }
            self.isFetching = false
            
            if Model?.status == "success" {
                let newRooms = Model?.data?.data ?? []
                if page == 1 {
                    self.rooms = newRooms
                } else {
                    self.rooms.append(contentsOf: newRooms)
                }
                
                let lastPage = Model?.data?.lastPage ?? page
                if page < lastPage {
                    self.currentPage = page + 1
                    self.canLoadMore = true
                } else {
                    self.canLoadMore = false
                }
                
                self.state = self.rooms.isEmpty ? .emptyScreen : .loaded(data: self.rooms)
            } else if page == 1 {
                self.state = .error(err ?? "")
            }
            // لو فشلت صفحة غير الأولى بنسيب الداتا اللي ظاهرة زي ما هي
        }
    }
}
