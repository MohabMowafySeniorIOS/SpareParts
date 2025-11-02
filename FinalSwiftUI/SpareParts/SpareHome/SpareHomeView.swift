//
//  SpareHomeView.swift
//  MyAuctions
//
//  Created by Moaaz on 09/07/2025.
//
import SwiftUI

enum orderType{
    case national
    case local
    case custom
}

struct SpareHomeView: View {
    private var userName: String = "user_name".localized
    @State private var rating: Double = 3
    @State private var searchFieldText: String = ""
    @State private var tabSelection: Int = 0
    @State private var isSelected: Bool = false
    @State private var height: CGFloat = 0
    @State private var width: CGFloat = 0
    @State var ordertype: orderType = .national
    @State private var sliderImages: [Image] = [
        Image.carImage,
        Image.carImage,
        Image.carImage,
        Image.carImage
    ]
    @State var navToNational: Bool = false
    @State var navTolocal: Bool = false
    @State var navToCustom: Bool = false
    var body: some View {
            NavigationStack{
                    VStack{
                        HomeTopBar(userName: userName)
                        ScrollView{
                            HomeSearchBar(searchFieldText: $searchFieldText)
                                .padding(.horizontal)
                            HomeImageSlider(tabSelection: $tabSelection, images: $sliderImages)
                                .padding(.horizontal)
                            TitleLabel(title: "order_now")
                                .padding(.leading)
                            HStack(){
                                HomeOrderTypeButton(title: "national_order", action: {
                                    navToNational = true
                                }, bgColor: .main, textColor: .cWhite)
                                .navigationDestination(isPresented: $navToNational) {
                                    CreateOrderView(mainOrderType: .national)
                                }
                                Spacer()
                                HomeOrderTypeButton(title: "local_order", action: {
                                    navTolocal = true
                                }, bgColor: .cWhite, textColor: .main)
                                .navigationDestination(isPresented: $navTolocal) {
                                    CreateOrderView(mainOrderType: .local)
                                }
                                Spacer()
                                HomeOrderTypeButton(title: "custom_order", action: {
                                    navToCustom = true
                                }, bgColor: .cWhite, textColor: .main)
                                .navigationDestination(isPresented: $navToCustom) {
                                    CreateOrderView(mainOrderType: .custom)
                                }
                                
                            }
                            .padding(.horizontal)
                            TitleLabel(title: "most_rated_vendors")
                                .padding(.leading)
                            ScrollView(.horizontal,showsIndicators: false) {
                                LazyHStack{
                                    ForEach(0..<10) { item in
                                        VendorCard(rating: $rating)
                                    }
                                }
                                .padding(.leading)
                            }
                        }
                    }
                }
            }
}

#Preview {
    SpareHomeView()
}









