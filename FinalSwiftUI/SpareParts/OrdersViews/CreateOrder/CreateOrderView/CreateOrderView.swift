//
//  CreateOrderView.swift
//  MyAuctions
//
//  Created by Mohab on 10/07/2025.
//

import SwiftUI

enum CreateOrderType: String {
    case local = "global_local"
    case national = "global_international"
    case custom = "custom"
}

enum CustomOrderMethod {
    case countryandcity
    case vendor
}

struct CreateOrderView: View {
    
    @State var mainOrderType: CreateOrderType
    @State var orderType: String = ""
    @State var notificationCount: Int = 9
    var title: String = "create_order".localized
    
    @State var isAddedCarSelectionBar: Bool = false
    @State var isAddedAddressBar: Bool = false
    
    @State var selectedType: DeliveryTypeEnum = .shop
    @State var isTerms: Bool = false
    @State var termsMandatory: Bool = false
    @State var customOrderMethod: CustomOrderMethod = .countryandcity
    @State private var showImages = false
    
    @State var is_car_validation_label: Bool = true
    @State var is_parts_validation_label: Bool = true
    @State var is_address_validation_label: Bool = true
    @State var is_country_validation_label: Bool = true
    @State var is_vednor_validation_label: Bool = true
    @State var is_terms_validation_label: Bool = true
    
    @ObservedObject private var viewModel: CreateOrderViewModel
    
    init(viewModel: CreateOrderViewModel, mainOrderType: CreateOrderType) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.mainOrderType = mainOrderType
    }
    
    var body: some View {
        ShowViewState(state: viewModel.state) { Model in
            mainContent
                .background(
                    Color(Color.backGroundColor)
                )
        }
        .background(
            Color(Color.backGroundColor)
        )
        .overlay {
            let selectedImages: [AttachMentModel?] = {
                guard let index = viewModel.selectedPartIndex,
                      viewModel.partsPiece.indices.contains(index) else {
                    return []
                }
                return viewModel.partsPiece[index].uploadPickedImages
            }()

            ItemsImagesViewPopup(
                isPresented: $showImages,
                images: selectedImages
            )
        }
        .background(
            Color(Color.backGroundColor)
        )
        .onAppear {
            if mainOrderType == .local {
                self.orderType = "local_order".localized
            } else if mainOrderType == .national {
                self.orderType = "national_order".localized
            } else {
                self.orderType = "custom_order".localized
            }

            if viewModel.specificVendor != nil {
                customOrderMethod = .vendor
            }

            // refresh the lookup lists so a car / address added from this screen
            // shows up when coming back, without touching what the user entered.
            viewModel.getMyCars()
            viewModel.getAddressAgenda()
        }
        
        
    }
    
    
    // MARK: - Main Content
    @State private var goNext = false
    @State private var goCountry = false
    @State private var goVendorList = false
  
    
    private var mainContent: some View {
        NavigationView {
            VStack {
                AppHeaderView(Title: title) {
                    viewModel.disMiss()
                }
                scrollView
                Spacer()
                createOrderButton
                handleNavigation
            }
        }.navigationBarHidden(true)
            .background(
                Color(Color.backGroundColor)
            )
    }
    
    @ViewBuilder
    private var handleNavigation: some View {
        NavigationLink("",
                       destination:  AddPieceView(viewModel: AddPieceViewModel(), partsPiece: $viewModel.partsPiece,selectedPartIndex:$viewModel.selectedPartIndex), isActive: $goNext)
        .navigationBarHidden(true)
        .hidden()
        NavigationLink("",
                       destination:  VendorListOrderView(viewModel: VendorListOrderViewModel(), vendorDetails: $viewModel.specificVendor), isActive: $goVendorList)
        .navigationBarHidden(true)
        .hidden()
        
        NavigationLink("",
                       destination:  ChooseCountryAndCityView(viewModel: ChooseCountryAndCityViewModel(), countryAndCities: $viewModel.countryAndCities), isActive: $goCountry)
        .navigationBarHidden(true)
        .hidden()
    }
    
    private var scrollView: some View {
        ScrollView {
            VStack(spacing: 15) {
                
                VStack {
                    orderTypeView
                    if mainOrderType == .custom {
                        if customOrderMethod == .vendor {
                            if !is_vednor_validation_label {
                                validationLabel(label: "Please Select Vendor".localized)
                            }
                        }else {
                            if !is_country_validation_label {
                                validationLabel(label: "Please Select Country".localized)
                            }
                        }
                    }
                   
                }
                VStack(spacing: 8) {
                    addCarView
                    if !is_car_validation_label {
                        validationLabel(label: "Please Select Car".localized)
                    }
                }
                VStack(spacing: 8) {
                    addPartsView
                    if !is_parts_validation_label {
                        validationLabel(label: "Please Select Part".localized)
                    }
                }
                
                deliveryType
                
                if selectedType == .home {
                    VStack(spacing: 8) {
                        addAddressView
                        if !is_address_validation_label {
                            validationLabel(label: "Please Select Address".localized)
                        }
                    }
                }
              
                
                VStack(spacing: 8) {
                    tesrmsView
                    if !is_terms_validation_label {
                        validationLabel(label: "agree_terms".localized)
                    }
                }
                
                
                
                
            }
            .padding(.horizontal)
            
        }
    }
    
    private func validationLabel(label: String) -> some View {
      return  HStack{
            Text(label)
                .font(addFont(fontType: .bold, size: 12))
                .foregroundStyle(Color.CRed)
            
            Spacer()
        }
    }
    
    private var addPartsView: some View {
        PartsList(parts: $viewModel.partsPiece,selectedPartIndex:$viewModel.selectedPartIndex) {
            goNext = true
        } showImages: { index in
            viewModel.selectedPartIndex = index
            showImages = true
        }
    }
    
    @ViewBuilder
    private var orderTypeView: some View {
        DoubleHTitleLabel(head: "Order Type".localized, tail: orderType)
        if mainOrderType == .custom {
            dependOnView
            dependOnCityView
            dependOnVendorView
            
        }
    }
    
    @ViewBuilder
    private var dependOnView: some View {
        HStack {
            Text("choose_order_method".localized)
                .foregroundStyle(Color.MainColor)
            Spacer()
        }
        SelectorBarCustomView(
            title: "country_city_selector".localized,
            isSelected: customOrderMethod == .countryandcity
        )
        .onTapGesture {
            viewModel.specificVendor = nil
            customOrderMethod = .countryandcity
        }
        SelectorBarCustomView(
            title: "vendor_selector".localized,
            isSelected: customOrderMethod == .vendor
        )
        .onTapGesture {
            viewModel.countryAndCities = []
            customOrderMethod = .vendor
        }
    }
    
    @ViewBuilder
    private var dependOnCityView: some View {
        if customOrderMethod == .countryandcity {
            SimpleSpareButton(
                buttonTitle: "add_country".localized,
                action: {
                    goCountry = true
                }, widthValue: 300, heightValue: 45)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                LazyHStack(spacing: 10) {
                    ForEach(viewModel.countryAndCities.indices,id: \.self) { index in
                        AddCityCard(model: viewModel.countryAndCities[index], delete: {
                            viewModel.countryAndCities.remove(at: index)
                        })
                    }
                }
                
            }
        }
    }
    
    @ViewBuilder
    private var dependOnVendorView: some View {
        if customOrderMethod == .vendor {
            SimpleSpareButton(buttonTitle: "show_vendors_menu".localized, action: {
                goVendorList = true
            }, widthValue: 300, heightValue: 45)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 10) {
                    if let vendor = viewModel.specificVendor {
                        AddVendorCard(Model: vendor) {
                            viewModel.specificVendor = nil
                        }
                    }
                }
                
            }
        }
    }
    
    
    @ViewBuilder
    private var deliveryType: some View {
        TitleLabel(title: "delivery_type".localized)
        DeliveryTypeSelector(
            selectedType: $selectedType, fieldType: .shop,
            title: "take_away".localized
        )
        .onTapGesture {
            selectedType = .shop
        }
        DeliveryTypeSelector(
            selectedType: $selectedType, fieldType: .home,
            title: "delivery".localized
        )
        .onTapGesture {
            selectedType = .home
        }
    }
    
    
    
    @ViewBuilder
    private var addCarView: some View {
        AddedCarSelectionBar(
            title: "added_cars_menu".localized,
            isClicked: $isAddedCarSelectionBar
        ){
            viewModel.coordinator.showAddCars(carId: nil)
        }
        .padding(.trailing)
        if isAddedCarSelectionBar {
            ForEach(viewModel.myCars.indices, id: \.self) { index in
                var item = viewModel.myCars[index]
                HStack(spacing: 8) {
                    RemoteImageView(imageUrl: item.brand?.logo?.path ?? "")
                        .frame(width: 40, height: 40)
                    CreateOrderSelectionBar(
                        isChecked: item.id == viewModel.selectedCar?.id, title: "\(item.full_name ?? "")",
                        imageName: ""
                    )
                }
                .onTapGesture {
                    viewModel.selectedCar = viewModel.myCars[index]
                }
            }
        }
    }
    
    @ViewBuilder
    private var addAddressView: some View {
        AddedCarSelectionBar(
            title: "added_address_menu".localized,
            isClicked: $isAddedAddressBar
        ) {
            viewModel.coordinator.showAddAddresses(addressModel: nil)
        }
        .padding(.trailing)
        if isAddedAddressBar {
            ForEach(viewModel.myAddresses.indices, id: \.self) { index in
                let item = viewModel.myAddresses[index]
                CreateOrderSelectionBar(
                    isChecked: item.id == viewModel.selectedAddresses?.id, title: item.address_text ?? "",
                    imageName: "mappin.and.ellipse"
                )
                .onTapGesture {
                    viewModel.selectedAddresses = viewModel.myAddresses[index]
                }
            }
        }
    }
    
    private var tesrmsView: some View {
        TermsView(
            isSelected: $isTerms, textColorChange: $termsMandatory
        )
        .onTapGesture {
            isTerms.toggle()
        }
    }
    
    private var createOrderButton: some View {
        SimpleSpareButton(
            buttonTitle: "create_order".localized,
            action: {
                var isValid = true
                if mainOrderType == .custom {
                    if customOrderMethod == .vendor {
                        if let vendor = viewModel.specificVendor {
                            viewModel.targets = [Targets(id: vendor.userId ?? 0, type: "trader")]
                            is_vednor_validation_label = true
                        }else {
                            isValid = false
                            is_vednor_validation_label = false
                        }
                    }else {
                        viewModel.targets = []
                        for item in viewModel.countryAndCities {
                            viewModel.targets.append(Targets(id: item.country?.id ?? 0, type: "country"))
                            for item2 in item.cities ?? [] {
                                viewModel.targets.append(Targets(id: item2.id ?? 0, type: "city"))
                            }
                        }
                        
                        if viewModel.countryAndCities.count == 0 {
                            isValid = false
                            is_country_validation_label = false
                        }else {
                            is_country_validation_label = true
                        }
                    }
                }
                
                if viewModel.selectedCar == nil {
                    isValid = false
                    is_car_validation_label = false
                }else {
                    is_car_validation_label = true
                }
                
                if selectedType == .home {
                    if viewModel.selectedAddresses == nil {
                        isValid = false
                        is_address_validation_label = false
                    }else {
                        is_address_validation_label = true
                    }
                }
               
                
                if viewModel.partsPiece.count == 0 {
                    is_parts_validation_label = false
                }else {
                    is_parts_validation_label = true
                }
                
                if !isTerms {
                    isValid = false
                    is_terms_validation_label = false
                }else {
                    is_terms_validation_label = true
                }
                
                if isValid {
                    var param: BaseParameters = .init(vehicle_id: "\(viewModel.selectedCar?.id ?? 0)",order_type: mainOrderType.rawValue, delivery_type: selectedType.rawValue)
                    if selectedType == .home {
                        param.address_id = "\(viewModel.selectedAddresses?.id ?? 0)" 
                    }
                    viewModel.CreateOrder(parameters: param)
                }
               
            }, widthValue: 330, heightValue: 50)
    }
}
