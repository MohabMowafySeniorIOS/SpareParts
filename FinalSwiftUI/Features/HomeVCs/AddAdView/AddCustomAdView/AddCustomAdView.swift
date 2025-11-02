import SwiftUI

struct AddCustomAdView: View {
    
  

    @State private var bars: [BarModel] = [
        BarModel(
            title: "category".localized,
            boxes: []),
        BarModel(
            title: "city".localized,
            boxes: []),
    ]

    @Environment(\.dismiss) var dismiss
    @State var selection: Int = 0
    @State var auctionName: String = ""
    @State var carDescription: String = ""
    @State var isCheckBox: Bool = false
    @State var isSheet: Bool = false
    @State var naviToHome: Bool = false
    
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State var pickedImages: [UIImage] = []
    
    @StateObject private var viewModel = AddCustomeAdViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true

    var body: some View {

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
            
            .onAppear {
                viewModel.getCategories()
                viewModel.getBrands()
                viewModel.getCities()
            }
            .onReceive(viewModel.$cityModel) { Model in
                bars[1].boxes = Model
             
            }
            .onReceive(viewModel.$categoryModel) { Model in
                bars[0].boxes = Model
              
            }
//            .onReceive(viewModel.$brandModel) { Model in
//                bars[2].boxes = Model
//              
//            }
            
            
            
        }

    }
    
    @ViewBuilder
    private var errorToast: some View {
        if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
            ToastView(message: errorMessage, backgroundColor: .cRed)
                .transition(.move(edge: .top))
                .zIndex(0.1)
        }
    }
    
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        NavigationStack {
            AppHeaderView(
                Title: "add_ad", action:{dismiss()})
            ScrollView {
                VStack {
                    HStack {
                        HStack {
                            AddPhotoButton(showImagePicker: $showImagePicker, selectedImage: selectedImage)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(pickedImages.indices, id: \.self) { item in
                                        Image(uiImage: pickedImages[item])
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 130, height: 130)
                                            .clipped()
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .frame(height: 150)
                        }
                        .padding(.leading)

                    }
                    VStack (spacing:15){
                        AddAdTextField(fieldText: $auctionName, barName: "product_name".localized)
                            .padding(.bottom)
                        
                        AddAdTextField(fieldText: $carDescription,barName: "price".localized)
                        
                        AddAdTextField(fieldText: $carDescription,barName: "product_description".localized)
                        
                        AddAdIconBar(bar: $bars[0])
                        
                        AddAdIconBar(bar: $bars[1])
                        
                        AddAdTextField(fieldText: $carDescription,barName: "price".localized)
                        
                        AddAdTextField(fieldText: $carDescription,barName: "contact_number".localized)
                        
                        AddAdTextField(fieldText: $carDescription,barName: "email".localized)
                        
                        HStack{
                            if isCheckBox {
                                Image(.checkedIcon)
                                    .padding(.trailing)
                            }else{
                                Image(.checkedIcon)
                                    .renderingMode(.template)
                                    .padding(.trailing)
                                    .foregroundStyle(.main)
                            }
                            Text("accept_terms_and_conditions".localized)
                            Spacer()
                        }
                        .padding(.vertical)
                        .onTapGesture {
                            isCheckBox.toggle()
                        }
                        
                        HStack{
                            CustomeButtonWithBorderColor(title: "cancel".localized) {
                                dismiss()
                            }
                            Spacer()
                            
                            ContentButtonView(title: "add".localized, action: {
                                viewModel.createListing(images : pickedImages,additional_images: pickedImages ,parameters:
                                        .init(
                                            
                                            city_id : "1",
                                            agree_terms : "true",
                                            title : "fieldState.auctionName",
                                            description : "fieldState.carDescibtion",
                                            price: "",
                                            contact_phone: "",
                                            contact_email: "",
                                            general_category_id : "1"
                                         
                                        )
                                                        )
                                isSheet.toggle()
                            })
                            .sheet(isPresented: $isSheet) {
                                ConfirmationAfterAdView()
                                    .presentationDetents([.height(400)])
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarBackButtonHidden()

    }
    

}

#Preview {
    AddCustomAdView()
}

