import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab = 4
    private let coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            
            TabView(selection: $selectedTab) {
                
                SpareHomeView(viewModel: SpareHomeViewModel(coordinator: coordinator), selectedTab: $selectedTab)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("home".localized)
                    }
                    .tag(4)
                
                VendorListView(viewModel: VendorListViewModel(coordinator: coordinator, locationManager: LocationManager()), selectedTab: $selectedTab)
                    .tabItem {
                        Image.vendor
                        Text("Vendors".localized)
                    }
                    .tag(3)
                
                if AuthService.userData?.token != nil {
                    MyOrdersView(viewModel: MyOrdersViewModel(coordinator: coordinator), selectedTab: $selectedTab)
                        .tabItem {
                            Image.order
                            Text("orders".localized)
                        }
                        .tag(2)
                    
                    FavouritsView(viewModel: FavouritsViewModel(coordinator: coordinator), selectedTab: $selectedTab)
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("favourites".localized)
                        }
                        .tag(1)
                }
                
                
                
                
                
                SidMenueVC(viewModel: sidMenueViewModel(coordinator: coordinator), selectedTab: $selectedTab)
                    .tabItem {
                        Image(systemName: "line.horizontal.3")
                        Text("menu".localized)
                    }
                    .tag(0)
                
                
            }
            
            
        }
        .accentColor(Color.MainColor)
        
    }
}
