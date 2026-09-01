//
//  OrderDetailsView.swift
//  MyAuctions
//
//  Created by Mohab Mowafy on 19/07/2025.
//

import SwiftUI

struct OrderDetailsView: View {
    @ObservedObject var viewModel: OrderDetailsViewModel
  
    @State private var showImages = false
    
    init(viewModel: OrderDetailsViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        mainContent
            .onChange(of: viewModel.showSheet) { newValue in
                if newValue == false {
                    viewModel.getOrderData(orderId: viewModel.orderId)
                }
            }
        
            .overlay {
                GenaricOrderBottomSheet(reasons: viewModel.problemTypes , isPresented: $viewModel.showSheet, orderId: viewModel.orderId, type: viewModel.bottomSheetType)
            }
        
        
    }
    
    private var mainContent: some View {
        VStack(spacing: 0) {
            headerView
            ShowViewState(state: viewModel.state) { Model in
                if let model = Model {
                    getClientScrollView(data: model)
                        .overlay {
                            let allImages = model.items?.compactMap { $0.images }.flatMap { $0 } ?? []
                            OfferImagesViewPopup(isPresented: $showImages, images: allImages)
                        }
                }
            }
            .ignoresSafeArea()
            .padding(.top)
            
            
            Spacer()
        }.background(
            Color(Color.backGroundColor)
        )
    }
    
    private var headerView: some View {
        AppHeaderView(Title: "order details".localized) {
            viewModel.coordinator.disMiss()
        }
    }
    
    private func getClientScrollView(data: OrderDetailsModel) -> some View {
        ScrollView {
            VStack(spacing: 16) {
                
                OrderInfoSection(data: data, canChat: data.can_chat == true, onClic: {
                    if data.hasChat == true {
                        viewModel.coordinator.showChatView(roomId: "\(data.chatID ?? 0)", title: "\(data.trader?.tradeName ?? "")-\(data.orderNumber ?? "")")
                    }else {
                        var param = BaseParameters()
                        param.order_id = "\(data.id ?? 0)"
                        param.trader_id = "\(data.trader?.id ?? 0)"
                        viewModel.createChat(param: param)
                    }
                })
                
                if data.orderType?.value == "custom" {
                    if let targets = data.targets, targets.count > 0 {
                        ScrollView(.horizontal,showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                                if targets[0].targetType.value == "country" {
                                    
                                    ForEach(targets.indices,id: \.self) { index in
                                        
                                        DetailsCityCard(model: targets[index].target)
                                        
                                        
                                    }
                                }else {
                                    DetailsVendorCard(Model: targets[0].target)
                                }
                                
                            }.padding()
                        }
                    }
                }
                
                
                if data.address != nil {
                    TitleLabel(title: "address details".localized)
                        .padding(.horizontal)
                    AddressSection(data: data)
                }
                TitleLabel(title: "car details".localized)
                    .padding(.horizontal)
                CarDetailsSection(data: data)
                TitleLabel(title: "ordered parts menu".localized)
                    .padding(.horizontal)
                OrderedPartsSection(data: data, showImages: $showImages)
                TitleLabel(title: "offers menu".localized)
                    .padding(.horizontal)
                HStack {
                    OffersSection(data: data) { offer in
                        viewModel.coordinator.showOfferDetails(offerId: "\(offer.id ?? 0)", orderId: "\(data.id ?? 0)", OfferModel: offer )
                    }
                    Spacer()
                }
                
                
                
                if data.canPay == true {
                    TitleLabel(title: "payment details".localized)
                        .foregroundStyle(Color.SecondaryColor)
                        .padding(.horizontal)
                    PaymentDetailsSection(data: data, paymentMethod: localizedPaymentMethod(data.paymentMethod ?? ""))
                }
                
                getButtens(data: data)
                    .padding(.top)

                if let ratingDetails = data.ratingDetails {
                    TitleLabel(title: "rating details".localized)
                        .padding(.horizontal)
                    RatingDetailsSection(rating: ratingDetails)
                }

                if data.problem_report != nil {
                    TitleLabel(title: "problem details".localized)
                        .foregroundStyle(Color.SecondaryColor)
                        .padding(.horizontal)
                    Text(data.problem_report?.description ?? "")
                }
                
                if localizedPaymentMethod(data.paymentMethod ?? "") != "--" {
                    ProblemDetails(data: data, paymentMethod: localizedPaymentMethod(data.paymentMethod ?? ""))
                        .padding(.horizontal)
                }
                
            }
        }.refreshable {
            viewModel.getOrderData(orderId: viewModel.orderId)
        }
    }
    func localizedPaymentMethod(_ method: String?) -> String {
        
        let value = method?
        
            .lowercased()
        
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if value.isEmpty {
            
            return "--"
            
        } else if value.contains("wallet") {
            
            return  "Wallet".localized
            
        } else {
            
            return "Visa".localized
            
        }
    }
    @ViewBuilder
    private func getButtens(data: OrderDetailsModel) -> some View {
        VStack {
            if data.canPay == true {
                paymentButton
            }
            if data.canCancel == true {
                cancelButton
            }
            if data.canConfirmReceipt == true {
                confirmReceiptButton
            }
            if data.canReport == true {
                reportButton
            }
            if data.canRate == true {
                rateButton
            }
            
            if data.can_download == true {
                downloadBillButton
            }
            
            if isClient == false {
                sendPriceButton
                shippingButton
                shippingDoneButton
                waitingForReceiptButton
                reportRedButton
            }
            
        }
    }
    private var cancelButton: some View {
        SimpleSpareButton(
            buttonTitle: "Cancel order".localized,
            action: {
                print("cancel_order tapped")
                viewModel.bottomSheetType = .cancel
                viewModel.showSheet = true
            },
            widthValue: 300,
            heightValue: 50
        )
    }
    
    private var paymentButton: some View {
        SimpleSpareButton(
            buttonTitle: "Payment".localized,
            action: {
                viewModel.coordinator.showGatWay(orderId: viewModel.orderId, price: viewModel.state.data?.totalAmount ?? 0.0)
            },
            widthValue: 300,
            heightValue: 50
        )
    }
    private var confirmReceiptButton: some View {
        WhiteSpareButton(
            buttonTitle: "Confirm receipt".localized,
            action: {
                viewModel.recept(orderId: viewModel.orderId)
            },
            widthValue: 300,
            heightValue: 50
        )
    }
    private var reportButton: some View {
        WhiteSpareButton(
            buttonTitle: "Report a problem".localized,
            action: {
                print("Report a problem tapped")
                viewModel.bottomSheetType = .reportProblem
                viewModel.showSheet = true
            },
            widthValue: 300,
            heightValue: 50
        )
    }
    private var rateButton: some View {
        SimpleSpareButton(
            buttonTitle: "Rate".localized,
            action: {
                print("Rate tapped")
                viewModel.bottomSheetType = .rate
                viewModel.showSheet = true
            },
            widthValue: 300,
            heightValue: 50
        )
    }
    private var downloadBillButton: some View {
        SimpleSpareButton(
            buttonTitle: "Download bill".localized,
            action: {
                if let url = URL(string: "\(hostName)general/orders/\(viewModel.orderId)/invoice") {
                    UIApplication.shared.open(url)
                }
            },
            widthValue: 300,
            heightValue: 50
        )
    }
    private var sendPriceButton: some View {
        SimpleSpareButton(
            buttonTitle: "Send price offer".localized,
            action: {
                print("Send price offer tapped")
            },
            widthValue: 300,
            heightValue: 50
        )
    }
    private var shippingButton: some View {
        WhiteSpareButton(
            buttonTitle: "Shipping".localized,
            action: {
                print("Shipping tapped")
                viewModel.updateStatus(urlEndPoint: "shipping")
            },
            widthValue: 300,
            heightValue: 50
        )
    }
    private var shippingDoneButton: some View {
        SimpleSpareButton(
            buttonTitle: "Shipping done".localized,
            action: {
                print("Shipping done tapped")
                viewModel.updateStatus(urlEndPoint: "shipped")
            },
            widthValue: 300,
            heightValue: 50
        )
    }
    private var waitingForReceiptButton: some View {
        WhiteSpareButton(
            buttonTitle: "Waiting for receipt".localized,
            action: {
                print("Waiting for receipt tapped")
                viewModel.updateStatus(urlEndPoint: "waiting_receipt")
            },
            widthValue: 300,
            heightValue: 50
        )
    }
    private var reportRedButton: some View {
        Button {
            viewModel.bottomSheetType = .reportProblem
            viewModel.showSheet = true
        } label: {
            Text("Report a problem".localized)
                .foregroundStyle(Color.CWhite)
                .frame(width: 300, height: 50)
                .background(
                    Color.CRed
                        .cornerRadius(20)
                )
        }
    }
}


struct OrderInfoRow: View {
    
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            
            Text(text)
                .foregroundStyle(Color.CGray1)
                .font(addFont(fontType: .Medium, size: 18))
        }
    }
}

struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.SecondaryColor)
            
            Text(text)
                .foregroundStyle(Color.CGray1)
                .font(addFont(fontType: .Medium, size: 18))
        }
    }
}

struct OrderInfoSection: View {
    let data: OrderDetailsModel?
    var canChat: Bool = false
    var onClic: ()->Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                // First Column Items
                VStack(alignment: .leading, spacing: 14) {
                    if let orderNumber = data?.orderNumber {
                        InfoRow(icon: "number", text: orderNumber)
                    }
                    if let countries = data?.countries, countries.count > 0 {
                        InfoRow(icon: "city", text: countries.map { $0.name ?? "" }.joined(separator: ", "))
                    }
                    if data?.trader != nil {
                        InfoRow(icon: "name", text: data?.trader?.tradeName ?? "")
                    }
                    if let status = data?.status?.label {
                        InfoRow(icon: "time", text: status)
                    }
                    if let phone = data?.client?.phone {
                        InfoRow(icon: "call me", text: phone)
                    }
                }
                
                Spacer(minLength: 16)
                
                // Second Column Items
                VStack(alignment: .leading, spacing: 14) {
                    if let cities = data?.cities, cities.count > 0 {
                        InfoRow(icon: "Country", text: cities.map { $0.name ?? "" }.joined(separator: ", "))
                    }
                    if let orderType = data?.orderType?.label {
                        InfoRow(icon: "local_shipping_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24", text: orderType)
                    }
                    if let createdAt = data?.createdAt {
                        InfoRow(icon: "calendar_clock_-1", text: createdAt)
                    }
                    if let itemCount = data?.items?.count {
                        InfoRow(icon: "car", text: "\(itemCount)")
                    }
                    if let deliveryType = data?.deliveryType?.label {
                        InfoRow(icon: "shipping", text: deliveryType)
                    }
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.CWhite)
            )
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
            .padding(.horizontal)
            
            if canChat {
                Button {
                    onClic()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "ellipsis.message.fill")
                            .font(.system(size: 22))
                        Text("Contact Trader".localized)
                        
                    }
                    .foregroundStyle(Color.CWhite)
                    .frame(width: 300, height: 50)
                    .background(
                        Color.MainColor
                            .cornerRadius(20)
                    )
                }
            }
            
        }
    }
}

struct AddressSection: View {
    let data: OrderDetailsModel?

    private var descriptionText: String {
        let desc = data?.address?.description?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return desc.isEmpty ? "no additional address description".localized : desc
    }

    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 0) {
                HStack {
                    Image("location-1")
                        .resizable()
                        .foregroundStyle(Color.SecondaryColor)
                        .frame(width: 24, height: 24)

                    Spacer()

                    Text(data?.address?.addressText ?? "")
                        .frame(width: 200, alignment: .trailing)
                }
                .padding()

                if let lat = data?.address?.latitude, let lng = data?.address?.longitude {
                    Divider()

                    Button {
                        openLocationOnMap(lat: lat, lng: lng)
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "map.fill")
                                .font(.system(size: 16))
                            Text("merchant.show_map".localized)
                                .font(addFont(fontType: .bold, size: 14))
                            Spacer()
                        }
                        .foregroundStyle(Color.MainColor)
                        .padding()
                    }
                }

                Divider()

                HStack {
                    Spacer()
                    Text("address more details".localized)
                        .foregroundStyle(Color.MainColor)
                        .font(addFont(fontType: .bold, size: 14))
                }
                .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.CWhite)
            )
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)

            Text(descriptionText)
                .foregroundStyle(Color.CGray1)
                .font(addFont(fontType: .Medium, size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }

    private func openLocationOnMap(lat: Double, lng: Double) {
        let urlString = "comgooglemaps://?q=\(lat),\(lng)&zoom=14"
        if let url = URL(string: urlString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let webURL = URL(string: "https://maps.google.com/?q=\(lat),\(lng)") {
            UIApplication.shared.open(webURL)
        }
    }
}

struct RatingDetailsSection: View {
    let rating: OrderRating

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: Double(index) <= (rating.rating ?? 0) ? "star.fill" : "star")
                        .font(.system(size: 22))
                        .foregroundColor(Double(index) <= (rating.rating ?? 0) ? .yellow : Color.CGray2)
                }
                Spacer()
                if let createdAt = rating.createdAt {
                    Text(createdAt)
                        .foregroundStyle(Color.CGray1)
                        .font(addFont(fontType: .Regular, size: 14))
                }
            }

            if let comment = rating.comment?.trimmingCharacters(in: .whitespacesAndNewlines),
               comment.isEmpty == false {
                Text(comment)
                    .foregroundStyle(Color.CGray1)
                    .font(addFont(fontType: .Medium, size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
        .padding(.horizontal)
    }
}

struct CarDetailsSection: View {
    let data: OrderDetailsModel?
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 14) {
                InfoRow(icon: "car-1", text: data?.vehicle?.category?.name/*?.name*/ ?? "")
                InfoRow(icon: "Car type", text: data?.vehicle?.brand?.name/*.name*/ ?? "")
                InfoRow(icon: "Car model", text: data?.vehicle?.chassisNumber ?? "")
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 14) {
                InfoRow(icon: "cars", text: data?.vehicle?.model.name/*?.name*/ ?? "")
                InfoRow(icon: "date", text: String(data?.vehicle?.year ?? 2020))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
        .padding(.horizontal)
    }
}

struct OrderedPartsSection: View {
    let data: OrderDetailsModel?
    @Binding var showImages: Bool
    var body: some View {
        LazyVStack(spacing: 12) {
            ForEach(data?.items ?? [], id: \.id) { item in
                OrderedPartCard(
                    part: .init(
                        name: item.partName ?? "",
                        number: item.partNumber ?? "",
                        count: String(item.quantity ?? 0),
                        type: item.partType?.label ?? "",
                        notes: item.description ?? ""
                    ),
                    id: item.id ?? 0
                ) {
                    print("show pictures tapped")
                    showImages = true
                    
                }
            }
        }
        .padding(.horizontal)
    }
}

struct OffersSection: View {
    let data: OrderDetailsModel?
    var offerAction: ((Offer) -> Void)?
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                if (data?.offers?.count ?? 0) > 0 {
                    ForEach(data?.offers ?? [], id: \.id) { offer in
                        OffersCardView(canMessage: data?.hasChat ?? false ,part: OffersCardModel(name: offer.trader?.tradeName ?? "", country: "saudia", city: "ryiadh", price: String(offer.totalAmount ?? 0)), buttonTitle: "show offer details".localized) {
                            offerAction?(offer)
                        } onMessage: {
                            print("Message tapped...")
                        }
                    }
                }else {
                    HStack {
                        Spacer()
                        Text("No Offers Exist".localized)
                            .foregroundColor(.red)
                        Spacer()
                    }
                    
                }
                
            }
            .padding(.leading)
        }
    }
}

struct PaymentDetailsSection: View {
    let data: OrderDetailsModel?
    var paymentMethod: String = "-"
    var body: some View {
        VStack(spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    InfoRow(icon: "number", text: data?.orderNumber ?? "")
                    InfoRow(icon: "mouny", text: "\(data?.totalAmount ?? 0) ريال")
                }
                
                Spacer(minLength: 40)
                
                VStack(alignment: .leading, spacing: 10) {
                    InfoRow(icon: "wallet", text: paymentMethod)
                    InfoRow(icon: "calendar_clock_-1", text: data?.createdAt ?? "")
                        .minimumScaleFactor(0.6)
                }
                .padding(.trailing)
            }
            Button {
                print("show payment details")
            } label: {
                Image(systemName: "arrow.down.to.line")
                    .foregroundStyle(Color.MainColor)
                    .font(.system(size: 25))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
        .padding(.horizontal)
    }
}

struct PaymentDetailsInfoView: View {
    let data: OrderDetailsModel?
    
    var body: some View {
        VStack(spacing: 18) {
            
            PaymentRow(
                title: "Date and Time".localized,
                value: data?.createdAt ?? "-"
            )
            
            PaymentRow(
                title: "Used Payment Methods".localized,
                value: data?.walletUsed == 1 ? "المحفظة" : "-"
            )
            
            PaymentRow(
                title: "Used Wallet Balance".localized,
                value: "\(data?.walletUsed ?? 0) ريال"
            )
            
            PaymentRow(
                title: "Payment Method Name".localized,
                value: data?.paymentMethod ?? "-"
            )
            
            PaymentRow(
                title: "Paid Amount".localized,
                value: "\(data?.totalAmount ?? 0) ريال"
            )
            
            PaymentRow(
                title: "Transaction Reference Number".localized,
                value: String(data?.id ?? 0)
            )
        }
        .padding(.horizontal)
    }
}


struct PaymentRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .foregroundStyle(Color.SecondaryColor)
                .font(addFont(fontType: .bold, size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(value)
                .foregroundStyle(Color.SecondaryColor)
                .font(addFont(fontType: .Regular, size: 14))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct ProblemDetails: View {
    let data: OrderDetailsModel?
    let paymentMethod: String
    var body: some View {
        VStack(spacing: 18) {
            
            PaymentRow(
                title: "Date and Time".localized,
                value: data?.createdAt ?? "-"
            )
            
            PaymentRow(
                title: "Used Payment Methods".localized,
                value: paymentMethod
            )
            
            //            Text("gfhjklkcdsiomvsavddasvmkl")
            //                .foregroundStyle(Color.CGray1)
            //                .font(addFont(fontType: .Medium, size: 16))
        }
    }
}
