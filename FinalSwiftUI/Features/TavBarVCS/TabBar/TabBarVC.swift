//import SwiftUI
//
//struct MainTabView: View {
//    @StateObject var menuVM = SideMenuViewModel()
//    var body: some View {
//        TabView {
//            HomeView()
//                .tabItem {
//                    Image(systemName: "house.fill")
//                    Text("الرئيسية")
//                }
//
//            MyAdsView()
//                .tabItem {
//                    Image(systemName: "doc.on.doc.fill")
//                    Text("إعلاناتي")
//                }
//
//            WalletVC()
//                .tabItem {
//                    Image(systemName: "wallet.pass.fill")
//                    Text("المحفظة")
//                }
//
////            FavoritesView()
////                .tabItem {
////                    Image(systemName: "heart.fill")
////                    Text("المفضلة")
////                }
//
//            SideMenuView()
//         
//                .tabItem {
//                    Image(systemName: "line.3.horizontal")
//                    Text("المزيد")
//                }
//        }
//        .accentColor(Color.teal) // Active tab icon and label color
//       // .environment(\.layoutDirection, .rightToLeft)
//    }
//}
//
//
//
//#Preview {
//    MainTabView()
//}
