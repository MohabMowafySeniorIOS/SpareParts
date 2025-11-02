import SwiftUI

struct ElectronicsCardModel: Identifiable {
    var id = UUID()
    var productName: String
    var productPrice: String
    var productlocation: String
    var productVendor: String
    var vendorImage: Image
    var productDate: String
    var productImage: Image
    var isFavourite: Bool = false
}

struct ElectronicsSectionView: View {
    
    @State var isNavi: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var searchText: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var navigateToPriceFilter: Bool = false

    @StateObject private var viewModel = ElectronicViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    
    

    @State private var smallSheet: Bool = false
    @State private var goToIndex: Int = 0
    
    @Binding var general_category_id : String

    var body: some View {
        //app top bar
        
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
            viewModel.getDate(search: "", city_id: "", general_category_id: general_category_id, price_from: "", price_to: "", order_by: "", order_direction: "", page: "1")
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
        NavigationStack{
            AppHeaderView(Title: "electronics") {
               dismiss()
            }
            ZStack{
                
                NavigationLink("", destination: FilterPriceandCityView(), isActive: $navigateToPriceFilter)
                
                NavigationLink("", destination: ProductDetailsView(), isActive: $isNavi)
                
                NavigationStack{
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))
                            .onTapGesture {
                                navigateToPriceFilter.toggle()
                            }

                        Image(systemName: "list.bullet")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))
                            .onTapGesture {
                                smallSheet.toggle()
                            }
                            .popover(
                                isPresented:$smallSheet,
                                arrowEdge: .top,
                                content:{
                                    ElectronicsSmallFilterSheet()
                                        .presentationCompactAdaptation(.popover)
                                })

                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20))
                                .foregroundStyle(.cGray1)
                                .onChange(of: searchText) { oldValue, newValue in
                                   
                                }

                            HStack{
                                TextField("search".localized, text: $searchText)
                                    .focused($isTextFieldFocused)
                            }
                            .onTapGesture {
                                isTextFieldFocused = false
                            }
                        }
                        .padding(.vertical, 13)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(style: StrokeStyle())
                                .fill(.cGray1)
                        )
                    }
                    .padding(.horizontal, 10)
                    .padding(10)

                    ScrollView {
                        ScrollViewReader{ proxy in
                            ForEach(viewModel.electronicModel.indices,id: \.self) { index in
                                let item = viewModel.electronicModel[index]
                                FavouritesCard(item: item)
                                    .padding(.horizontal)
                                .id(item.id)
                                .onTapGesture {
                                    isNavi.toggle()
                                }
    //                            .fullScreenCover(isPresented: $isNavi, content: {ProductDetailsView()})
                            }
                        }
                    }.navigationBarBackButtonHidden()
                }
            }
            
        }
    }
}

#Preview {
    ElectronicsSectionView(general_category_id: .constant("1"))
}


