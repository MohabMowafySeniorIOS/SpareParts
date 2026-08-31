//
//  SpareHomeView.swift
//  MyAuctions
//
//  Created by Mohab on 09/07/2025.
//
import SwiftUI

enum orderType{
    case national
    case local
    case custom
}

struct SpareHomeView: View {
    @Binding var selectedTab: Int
    @State private var searchFieldText: String = ""
    @State private var tabSelection: Int = 0
    @ObservedObject private var viewModel: SpareHomeViewModel
    @State private var showLoginPopup: Bool = false
    var isLogin = (AuthService.userData?.token != nil) ? true : false
    
    init(viewModel: SpareHomeViewModel,selectedTab: Binding<Int>) {
        _selectedTab = selectedTab
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        
    }
   
    var body: some View {
        ShowViewState(state: viewModel.state) { Model in
            mainContent
                .background(
                    Color(Color.backGroundColor)
                )
        }.overlay {
            
            if showLoginPopup {
                
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                LoginRequiredPopup(
                    onLogin: {
                        viewModel.coordinator.logOut()
                    },
                    onCancel: {
                        showLoginPopup = false
                    }
                )
            }
        }
    }
    
    private var mainContent: some View {
            VStack {
                topParView
                scrollViews()
            }
    }
    
    private var topParView: some View {
        HomeTopBar(userName: AuthService.userData?.full_name ?? "", notificationAction: {
            if isLogin {
                viewModel.coordinator.showNotification()
            }else {
                showLoginPopup = true
            }

        }, notificationCount: viewModel.unreadNotificationsCount)
        .onAppear {
            viewModel.getUnreadNotificationsCount()
        }
    }
    
    @ViewBuilder
    private func scrollViews() -> some View {
            ScrollView{
                HomeSearchBar(searchFieldText: $searchFieldText, searchAction: {
                    selectedTab = 3
                })
                    .padding(.horizontal)
                HomeImageSlider(tabSelection: $tabSelection, images: viewModel.state.data??.banners ?? [])
                    .padding(.horizontal)
                TitleLabel(title: "order_now".localized)
                    .padding(.leading)
                    .padding(.vertical,8)
                orderTypes
                mostRated

            }
    }
    
    private var orderTypes: some View {
        HStack{
            HomeOrderTypeButton(title: "national_order", action: {
                if isLogin {
                    viewModel.showCreateOrder(mainOrderType: .national, specificVendor: nil)
                }else {
                  showLoginPopup = true
                }
                
            }, bgColor: Color.MainColor, textColor: Color.CWhite)
            Spacer()
            HomeOrderTypeButton(title: "local_order", action: {
                if isLogin {
                    viewModel.showCreateOrder(mainOrderType: .local, specificVendor: nil)
                }else {
                  showLoginPopup = true
                }
               
            }, bgColor: Color.CWhite, textColor: Color.MainColor)
            Spacer()
            HomeOrderTypeButton(title: "custom_order", action: {
                if isLogin {
                    viewModel.showCreateOrder(mainOrderType: .custom, specificVendor: nil)
                }else {
                  showLoginPopup = true
                }
                
            }, bgColor: Color.CWhite, textColor: Color.MainColor)
            
        }
        .padding(.horizontal)
    }
    
    private var mostRated: some View {
        VStack {
            TitleLabel(title: "most_rated_vendors".localized)
                .padding(.leading)
                .padding(.vertical,8)
            ScrollView(.horizontal,showsIndicators: false) {
                LazyHStack{
                    ForEach(viewModel.tradersArr, id: \.id) { item in
                        VendorCard(vendorsModel: item, orderNow: {
                            
                            viewModel.coordinator.vendorDetails(rating: item.ratingAvg ?? 0.0, vendorId: "\(item.id)")
                            
                        }, favouriteAction: {
                            if isLogin {
                                viewModel.handleFavourite(vendor: item)
                            }else {
                                showLoginPopup = true
                            }
                            
                        })
                        .onTapGesture {
                            viewModel.coordinator.vendorDetails(rating: item.ratingAvg ?? 0.0, vendorId: "\(item.id)")
                        }
                    }
                }
                .padding(.leading)
                
            }
        }.padding(.top)
    }
   
}
