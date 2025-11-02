import SwiftUI

struct MainTabView: View {
    
    @State  var showSidebar = false
    @State private var previousTab: [Int] = []
    @EnvironmentObject var navigationState:AppState
    @State var navi: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var itemSelected: SideMenuSelectedItem = .FAQ

    var body: some View {
        NavigationStack{
            ZStack {
                NavigationLink("", destination: CarAuctionsView(), isActive: $navi)
                
                TabView(selection: $navigationState.mainTabSelection) {
                  
                    SpareHomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("home".localized)
                        }
                        .tag(4)
                   
                    VendorssecondView()
                        .tabItem {
                            Image.vendor
                            Text("vendor".localized)
                        }
                        .tag(3)
                    
                    MyOrdersView()
                        .tabItem {
                            Image.order
                            Text("orders".localized)
                        }
                        .tag(2)
                    
                    FavouritesView()
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("favourites".localized)
                        }
                        .tag(1)
                    
                   
                    
                    Color.clear
                        .tabItem {
                            Image(systemName: "line.horizontal.3")
                            Text("menu".localized)
                        }
                        .tag(0)
                        
                  
                }
                .onChange(of: navigationState.mainTabSelection) { newValue in
                    if newValue == 0 {
                        withAnimation {
                            showSidebar = true
                        }
                        if let last = previousTab.last {
                            navigationState.mainTabSelection = last
                        } else {
                            navigationState.mainTabSelection = 4 // fallback tab if previousTab empty
                        }
                    } else {
                        if newValue != 0 && previousTab.last != newValue {
                            previousTab.append(newValue)
                        }
                    }
                }

                if showSidebar {
                    SidebarView(
                        showSidebar: $showSidebar, onClose: {
                            withAnimation { showSidebar = false }
                        },
                        itemSelected: $itemSelected
                    )
                    .zIndex(1)
                }
            }
            .accentColor(.main)

        }    }
}
