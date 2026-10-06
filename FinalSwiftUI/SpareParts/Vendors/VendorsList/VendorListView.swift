//
//  MyAuctions
//
//  Created by Mohab on 10/07/2025.
//

import SwiftUI

struct FilterObject {
     var orderBy: SortedType?
   
}

struct VendorListView: View {
    @State private var showLoginPopup: Bool = false
    var isLogin = (AuthService.userData?.token != nil) ? true : false
    @State var isVendorMenu: Bool = false
    @State var goToCountryAndCity: Bool = false
    @ObservedObject private var viewModel: VendorListViewModel
    @Binding var selectedTab: Int
    
//    @State var isNew: Bool?
//    @State var isFar: Bool?
//    @State var isBest: Bool?
    init(viewModel: VendorListViewModel,selectedTab: Binding<Int>) {
        _selectedTab = selectedTab
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    var body: some View {
        mainContent
            .overlay {
                
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
            .background(
                Color(Color.backGroundColor)
            )
        
            
        
        
    }
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        
        VStack{
            AppHeaderView(Title: "Vendors List".localized,hideBackButton: true) {}
            searchView
            filterView
            Spacer()
            ShowViewState(state: viewModel.state) { Model in
                vendorList
            }
            
            handleNavigation
            Spacer()
        }
    }
    
    private var searchView: some View {
        HomeSearchBar(searchFieldText: $viewModel.fieldText, searchAction: {
            viewModel.refresh()
        })
        .padding(.horizontal)
    }
    
    private var filterView: some View {
        HStack{
            Spacer()
            
            Image(systemName: "list.bullet")
                .foregroundStyle(Color.CBlack)
                .font(.system(size: 25))
                .onTapGesture {
                    isVendorMenu = true
                }
                .sheet(isPresented: $isVendorMenu) {
                    VendorsMenuFilterCardView(filterObject: $viewModel.filterObject, isVendorMenu: $isVendorMenu)
                        .presentationDetents([.height(310)])
                }
            
            
            Image(systemName: "slider.horizontal.3")
                .foregroundStyle(Color.CBlack)
                .font(.system(size: 25))
                .onTapGesture {
                    goToCountryAndCity = true
                }
        } .padding(.horizontal)
    }
    
    private var vendorList: some View {
        ScrollView(showsIndicators: false){
            LazyVStack(spacing: 16) {
                ForEach(viewModel.vendorData) { vendor in
                    VendorCardWithLocation(vendor: vendor, orderNow: {
                        if isLogin {
                            viewModel.coordinator.createOrder(mainOrderType: .custom, specificVendor: vendor)
                        }else {
                          showLoginPopup = true
                        }

                     //   viewModel.coordinator.vendorDetails(rating: vendor.ratingAvg ?? 0.0, vendorId: "\(vendor.id)")
                    }, openLocation: {
                        viewModel.openGoogleMaps(lat: vendor.latitude ?? 0.0, lng: vendor.longitude ?? 0.0)
                    }, pressFavourite: {
                        if isLogin {
                            viewModel.handleFavourite(traderModel: vendor)
                        }else {
                            showLoginPopup = true
                        }

                    })
                    .onAppear {
                        viewModel.loadMoreIfNeeded(currentVendor: vendor)
                    }
                    .onTapGesture {
                        viewModel.coordinator.vendorDetails(rating: vendor.ratingAvg ?? 0.0, vendorId: "\(vendor.id)")
                    }
                }

                if viewModel.canLoadMore {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
            }
        }
        .refreshable {
            viewModel.refresh()
        }
        .padding(.top)
        .padding(.horizontal, 16)


    }
    
    private var handleNavigation: some View {
        NavigationLink("",
                       destination:  ChooseCountryAndCityView(viewModel: ChooseCountryAndCityViewModel(), countryAndCities: $viewModel.countryAndCities), isActive: $goToCountryAndCity)
        .navigationBarHidden(true)
        .hidden()
    }
}
