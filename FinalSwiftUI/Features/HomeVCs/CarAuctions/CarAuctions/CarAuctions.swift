import SwiftUI



struct SearchTextModifier: ViewModifier {
    @State var padding: CGFloat
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
                .padding(.vertical, padding)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(style: StrokeStyle())
                        .fill(.cGray1)
                )

            // Makes it stay above the keyboard
        }
    }
}

struct CarAuctionsView: View {

    @Environment(\.dismiss) var dismiss
    @State var searchText: String = ""
    @State var whitecardColor: Color = .cGray4
    @State var clearcardColor: Color = .clear
    @State var isNavi: Bool = false
    @State var isFavourite: Bool = false

    @State var cardInfos = [AuctionItemData]()
    
    @StateObject private var viewModel = CarAuctionViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true

    var body: some View {
        NavigationStack{
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
                viewModel.getAuctions()
            }
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
            AppHeaderView(
                Title: "car_auctions",
                action: {dismiss()})
            ZStack {
                NavigationLink( "", destination: CarAuctionDetailsView(), isActive: $isNavi)
                VStack {
                    ScrollView {
                        HStack {
                            HStack {
                                NavigationLink(
                                    destination: FilterCarStatesView()
                                ) {
                                    Image(systemName: "slider.horizontal.3")
                                        .foregroundStyle(.main)
                                        .font(.system(size: 30))
                                }
                                NavigationLink(
                                    destination: FilterPriceandCityView()
                                ) {
                                    Image(systemName: "list.bullet")
                                        .foregroundStyle(.main)
                                        .font(.system(size: 30))
                                }
                            }

                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.cGray1)
                                    .onTapGesture {
                                        //add search func
                                    }

                                TextField("search", text: $searchText)
                            }
                            .modifier(SearchTextModifier(padding: 13))
                        }
                        .padding(.horizontal, 10)
                        .padding(10)

                        VStack(spacing: 20) {
                            ForEach(viewModel.auctionModel.indices, id: \.self) { index in
                                
                                var item = viewModel.auctionModel[index]
                             
                                CarAuctionCard(Item: item,index:index)
                                //remove the next part to enable favourite button
//                                .onTapGesture {
//                                    isNavi.toggle()
//                                }
                            }
                        }
                    }

                }.background(.bgView)

            }.navigationBarBackButtonHidden()

        }
    }
}



#Preview {
    CarAuctionsView()
}
