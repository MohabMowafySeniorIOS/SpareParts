import SwiftUI

struct MyAdsView: View {
    enum AdsTab {
        case ads, subscribed
    }

  

    @State var ButtonBgColor: Color = .main
    @State var ButtonTextColor: Color = .cWhite
    @State var selectedTab: AdsTab = .ads
    @State var isSheetPresented: Bool = false
    @State var biggerSheet: Bool = false
    @State var biggerSheettwo: Bool = false
    @State var showAddAdSheet: Bool = false
    @State var navigateToCarAuctions: Bool = false
    @State var navigateToCustomAd: Bool = false
    @State var isPresented: Bool = false
    
    @StateObject private var viewModel = MyAdsViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true

    var body: some View {
        ZStack {
            errorToast
            if viewModel.isLoading == true {
                LoaderView(rotation: $rotation, isLoading: $isLoading)
                    .frame(width: 100, height: 100)
            } else {
                mainContent
            }
        }
        .onAppear {
            viewModel.get_my_listings()
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
            VStack {
                ZStack {
                    NavigationLink("", destination: AddAdMainView(), isActive: $navigateToCarAuctions)
                    Text("my_ads".localized.capitalized)
                        .foregroundStyle(.cWhite)
                        .font(.system(size: 20))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.main)
                
                ContentButtonView(title: "add_ad".localized) {
                    showAddAdSheet.toggle()
                }
                .padding(.top)
                .padding(.horizontal,40)
                .sheet(isPresented: $showAddAdSheet) {
                    ChooseAdTypeView(navigateToCarAuctions: $navigateToCarAuctions, navigateToCustomAd: $navigateToCustomAd, isPresented: $isPresented)
                        .presentationDetents([.height(300)])
                }
                       
                HStack {
                    Image(systemName: "list.bullet")
                        .foregroundStyle(.main)
                        .font(.system(size: 25))
                        .frame(width: .infinity,alignment: .center)
                        .onTapGesture {
                            isSheetPresented.toggle()
                        }
                        .sheet(isPresented: $isSheetPresented, content: {
                            let x = biggerSheet
                            MenuFilterSheetView(biggerSheet: $biggerSheet, biggerSheettwo: $biggerSheettwo)
                                .presentationDetents([biggerSheet || biggerSheettwo ? .medium : .height(250)])
                                .frame(maxHeight: .infinity)
                        })

                    HStack {
                        Text("ads".localized)
                            .foregroundStyle(
                                selectedTab == .ads ? .cWhite : .main
                            )
                            .padding(10)
                            .padding(.horizontal)
                            .background(
                                selectedTab == .ads
                                    ? .main.opacity(0.8) : .cWhite
                            )
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedTab = .ads
                            }

                        Text("subscribed_auctions".localized.capitalized)
                            .foregroundStyle(
                                selectedTab == .subscribed ? .cWhite : .main
                            )
                            .padding(10)
                            .padding(.horizontal)
                            .background(
                                selectedTab == .subscribed
                                    ? .main.opacity(0.8) : .cWhite
                            )
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedTab = .subscribed
                            }
                    }
                    .padding(7)
                    .padding(.horizontal, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle())
                            .fill(.main))
                    .frame(maxWidth:.infinity,alignment:.center)

                }.padding()

                ScrollView {
                    
                        ForEach(viewModel.myAdsModel.indices,id:\.self) { index in
                            let bgColor = (index % 2 == 0) ? Color.cGray3.opacity(0.2) : Color.clear
                            let item = viewModel.myAdsModel[index]
                            AdBlockItem(
                               item: item,
                               bgColor: bgColor )
                        }

                }

            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MyAdsView()
}

