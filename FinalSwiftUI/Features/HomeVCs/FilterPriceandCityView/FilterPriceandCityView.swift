import SwiftUI


struct FilterPriceandCityView: View {
    
    @State var fieldText:String = ""
    @State var isPriceTapped: Bool = false
    @State var isCityTapped: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var naviToElectronics: Bool = false
    @EnvironmentObject var navi: AppState
    
    
    
    @StateObject private var viewModel = FilterPriceandCityViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    @State private var isNavigating = false
    @State private var showAlert = false
    @State private var validationError = ""
    
    var body: some View {
        
        AppHeaderView(Title:"filter", action: {dismiss()})
        
        NavigationStack {
          
                ZStack {
                    errorToast
                    if viewModel.isLoading == true {
                        LoaderView(rotation: $rotation, isLoading: $isLoading)
                            .frame(width: 100, height: 100)
                    } else {
                        mainContent
                    }
                }
               
                
            
        }.dismissKeyboardOnTap()
            .navigationBarBackButtonHidden()
            .onAppear {
                viewModel.getCities()
            }
        
        Spacer()
    }
    
    
    
    @ViewBuilder
    private var errorToast: some View {
        if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
            ToastView(message: errorMessage, backgroundColor: .red)
                .transition(.move(edge: .top))
                .zIndex(0.1)
        }
    }
    // MARK: - Main Content
    
    private var mainContent: some View {
//        ZStack{
//            NavigationLink("", destination: ElectronicsSectionView(), isActive: $naviToElectronics)
//        }
        
        VStack {
            ScrollView{
                // For Price filter
                FilterPriceBar(barName: "price", isActive: $isPriceTapped)
                    .background()
                    .onTapGesture {
                        isPriceTapped.toggle()
                    }
    //                .padding(.top)
                // Show TextField for price filter
                if isPriceTapped  {
                    TextField("", text: $fieldText)
                        .keyboardType(.numberPad)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .fill(.main.opacity(0.4))
                        )
                        .padding(.horizontal,15)
                }
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: .infinity,height: 2)
                    .foregroundStyle(.main.opacity(0.4))
                    .padding(.top,5)
                // For City filter
                FilterPriceBar(barName: "city",isActive: $isCityTapped)
                    .onTapGesture {
                        isCityTapped.toggle()
                    }
                // Show City-related content
                if isCityTapped {
                    ForEach(viewModel.cityModel.indices, id: \.self) { index in
                        var filter = viewModel.cityModel[index]
                        HStack{
                            CityFilterBox(isBoxActive: filter.isActive, city: filter.name ?? "")
                            Spacer()
                        }
                        .padding(.horizontal)
                        .onTapGesture {
                            viewModel.cityModel[index].isActive = !viewModel.cityModel[index].isActive
                       isCityTapped = true
                            
                        }
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            
            HStack{
                ContentButtonView(title: "save".localized) {
                    dismiss()
                }
                Spacer()
                CustomeButtonWithBorderColor(title: "reset".localized) {
                    
                    fieldText = ""
                    
                    viewModel.cityModel = viewModel.cityModel.map({ item in
                        var item = item
                        item.isActive = false
                        return item
                    })
                }
            }.padding(.horizontal)

        }
     
        
        
    }
}

#Preview {
    FilterPriceandCityView()
}

struct FilterPriceBar: View {
    
    var barName: String
    @Binding var isActive: Bool
    
    var body: some View {
        HStack{
            Text(barName.localized)
                .foregroundStyle(.cBlack)
                .font(addFont(fontType: .Medium, size: 16))
            
            Spacer()
            
            Image(systemName: "chevron.up")
                .foregroundStyle(.main)
                .font(.system(size: 25))
                .scaleEffect(x:isActive == true ? -1 : 1, y:isActive == true ? -1 : 1)
            
        }
        .padding(.horizontal,15)
        .frame(maxWidth: .infinity)
    }
}

struct CityFilterBox: View {
    
    var isBoxActive: Bool
    var city: String
    
    var body: some View {
        HStack{
            if !isBoxActive{
                Image(.unCheckedIcon)
            }else{
                Image(.checkedIcon)
                    .renderingMode(.template)
                    .foregroundStyle(.main)
            }
                Text(city)
                    .foregroundStyle(isBoxActive ? .cBlack : .cGray1)
            }
        }
    }
