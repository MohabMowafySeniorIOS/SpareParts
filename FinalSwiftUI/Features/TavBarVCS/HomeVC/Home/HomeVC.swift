//
//  HomeVC.swift
//  FinalSwiftUI
//
//  Created by mohab mowafy on 17/05/2025.
//

import SwiftUI



struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    
    
    @EnvironmentObject var navi: AppState
    
    @State var restart: Bool = false
    

    @State private var isSheetPresent: Bool = false
    @State private var navigateToCarAuctions: Bool = false
    @State private var navigateToCustomAd: Bool = false
    @State var restartLanguage: Bool = false

  

    @State var columns: [GridItem] = [
        GridItem(spacing: 15),
        GridItem(spacing: 15),
        GridItem(),
    ]
    
    @State var tabViewImages: [Image] = [
        Image(.image2),
        Image(.car),
        Image(.car)
    ]
    
    

    var body: some View {
        
        ZStack {
            errorToast
            if viewModel.isLoading == true {
                LoaderView(rotation: $rotation, isLoading: $isLoading)
                    .frame(width: 100, height: 100)
            } else {
                mainContent
            }
        }.onAppear {
            viewModel.get_categories()
        }
        
        
    }
    
    @ViewBuilder
    private var errorToast: some View {
        if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
            ToastView(message: errorMessage, backgroundColor: .red)
                .transition(.move(edge: .top))
                .zIndex(1)
        }
    }
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HomeHeader(
                        Title: "home",
                        notificationCount: 10,
                        isSheetPresented: $isSheetPresent,
                        naviToCarAuction: $navigateToCarAuctions,
                        naviToCustomAd: $navigateToCustomAd)
                    ScrollView {
                        VStack {
                            NavigationLink(destination: CarAuctionsView()) {
                                
                                TabView{
                                    ForEach(0..<tabViewImages.count, id: \.self) { index in
                                        tabViewImages[index]
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height:170)
                                            .clipped()
                                            .tag(index)
                                    }
                                    
                                }
                                .frame(height:180)
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                
                              
                            }

                            Text("other_sections".localized)
                                .font(addFont(fontType: .Medium, size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(5)
                                .padding(.leading,5)

                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(viewModel.categoryModel.indices,id: \.self) { index in
                                    var item = viewModel.categoryModel[index]
                                    VStack{
                                        GridContent(
                                            item: item,
                                            cardDestination: {
                                                AnyView(ElectronicsSectionView(general_category_id: .constant("\(item.id ?? 0)")))
                                            }
                                        )
                                        
                                    }
                                }
                            }.padding(.horizontal, 7)

                            Spacer()
                        }
                    }.scrollIndicators(.hidden)
                }
            }
        }
        .onChange(of: restart) { _, _ in
            navi.goToHome()
        }

    }
}



//grid content
struct GridContent: View {

    var item :GeneralCategory?
//    let contentImage: Image
//    let contentDescription: String
    let cardDestination: () -> AnyView

    var body: some View {
        NavigationLink {
            cardDestination()
        } label: {
            VStack {
                RemoteImageView(imageUrl: item?.image ?? "")
//                    .resizable()
//                    .scaledToFit()

                Text(item?.name ?? "")
                    .foregroundStyle(.cBlack)
            }
        }
    }
}

#Preview{
    HomeView()
}
