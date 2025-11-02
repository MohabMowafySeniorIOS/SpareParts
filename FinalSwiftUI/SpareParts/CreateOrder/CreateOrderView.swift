//
//  CreateOrderView.swift
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
//

import SwiftUI

enum CreateOrderType {
    case local
    case national
    case custom
}

enum CustomOrderMethod {
    case countryandcity
    case vendor
}

struct CreateOrderView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CreateOrderViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true

    @State var mainOrderType: CreateOrderType
    @State var orderType: String = ""
    @State var notificationCount: Int = 9
    var title: String = "create_order"

    @State var isAddedCarSelectionBar: Bool = false
    @State var isAddedAddressBar: Bool = false

    @State var isCarChecked: Bool = false
    @State var selectedType: DeliveryType = .home
    @State var isTerms: Bool = false
    @State var termsMandatory: Bool = false
    @State var customOrderMethod: CustomOrderMethod = .countryandcity

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
            if mainOrderType == .local {
                self.orderType = "local_order"
            } else if mainOrderType == .national {
                self.orderType = "national_order"
            } else {
                self.orderType = "custom_order"
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
            NormalAppBar(title: title) {
                dismiss()
            }
            ScrollView {
                VStack(spacing: 15) {

                    DoubleHTitleLabel(head: "delivery_type", tail: orderType)

                    if mainOrderType == .custom{
                    HStack {
                        Text("choose_order_method")
                            .foregroundStyle(.main)
                        Spacer()
                    }
                    SelectorBarCustomView(
                        title: "country_city_selector",
                        isSelected: customOrderMethod == .countryandcity
                    )
                    .onTapGesture {
                        customOrderMethod = .countryandcity
                    }
                    SelectorBarCustomView(
                        title: "vendor_selector",
                        isSelected: customOrderMethod == .vendor
                    )
                    .onTapGesture {
                        customOrderMethod = .vendor
                    }

                    if customOrderMethod == .countryandcity {
                        SimpleSpareButton(
                            buttonTitle: "add_country",
                            action: {

                            }, widthValue: 300, heightValue: 45)

                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            LazyHStack(spacing: 10) {
                                ForEach(0..<5) { index in
                                    AddCityCard()
                                }
                            }

                        }
                    }
                    if customOrderMethod == .vendor {
                        SimpleSpareButton(buttonTitle: "show_vendors_menu", action: {
                            
                        }, widthValue: 300, heightValue: 45)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            LazyHStack(spacing: 10) {
                                ForEach(0..<5) { index in
                                    AddVendorCard()
                                }
                            }

                        }
                    }

                     }

                    AddedCarSelectionBar(
                        title: "added_cars_menu",
                        isClicked: $isAddedCarSelectionBar
                    )
                    .padding(.trailing)
                    if isAddedCarSelectionBar {
                        ForEach(viewModel.cars.indices) { index in
                            var item = viewModel.cars[index]
                            CreateOrderSelectionBar(
                                isChecked: item.isSelected, title: item.name,
                                imageName: ""
                            )
                            .onTapGesture {
                                viewModel.cars[index].isSelected.toggle()
                            }
                        }
                    }
                    PartsList(parts: viewModel.parts)
                    TitleLabel(title: "delivery_type")
                    DeliveryTypeSelector(
                        selectedType: $selectedType, fieldType: .home,
                        title: "take_away"
                    )
                    .onTapGesture {
                        selectedType = .home
                    }
                    DeliveryTypeSelector(
                        selectedType: $selectedType, fieldType: .shop,
                        title: "delivery"
                    )
                    .onTapGesture {
                        selectedType = .shop
                    }
                    AddedCarSelectionBar(
                        title: "added_address_menu",
                        isClicked: $isAddedAddressBar
                    )
                    .padding(.trailing)
                    if isAddedAddressBar {
                        ForEach(viewModel.addedAddress.indices) { index in
                            var item = viewModel.addedAddress[index]
                            CreateOrderSelectionBar(
                                isChecked: item.isSelected, title: item.address,
                                imageName: "mappin.and.ellipse"
                            )
                            .onTapGesture {
                                viewModel.addedAddress[index].isSelected
                                    .toggle()
                            }
                        }
                    }
                    TermsView(
                        isSelected: $isTerms, textColorChange: $termsMandatory
                    )
                    .onTapGesture {
                        isTerms.toggle()
                    }
                    SimpleSpareButton(
                        buttonTitle: "create_order",
                        action: {

                        }, widthValue: 330, heightValue: 50)
                }
                .padding(.horizontal)

            }
        }
        .navigationBarBackButtonHidden()

    }
}

#Preview {
    CreateOrderView(mainOrderType: .local, orderType: "local")
}
