//
//  VendorDetailsView.swift
//  MyAuctions
//
//  Created by Mohab on 14/07/2025.
//

import SwiftUI

struct VendorDetailsView: View {
    @State private var showLoginPopup: Bool = false
    var isLogin = (AuthService.userData?.token != nil) ? true : false
    var rating: Double
    @State var starSize: CGFloat = 20
    @State var starPadding: CGFloat = 3
    @State var tabSelection: Int = 0
    
    @State var currentImage: String?
    
    
    @State var isFavourit: Bool = false
    @State private var goRating = false
    
    @ObservedObject private var viewModel: VendorDetailsViewModel
    init(viewModel: VendorDetailsViewModel, rating: Double ) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.rating = rating
    }
    
    var body: some View {
        mainContent
            .overlay {
                
                if showLoginPopup {
                    
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    LoginRequiredPopup(
                        onLogin: {
                            viewModel.coordinator.logOut()
                        },
                        onCancel: {
                            showLoginPopup = false
                        }
                    )
                }
            }
            .background(
                Color(Color.backGroundColor)
            )
        
    }
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        VStack{
            AppHeaderView(Title: "Vendor Details".localized) {
                viewModel.coordinator.disMiss()
            }
            
            ShowViewState(state: viewModel.state) { Model in
                scrollView
            }
            Spacer()
            handleNavigation
        }
        
    }
    
    private var scrollView: some View {
        
        VStack(spacing:0){
            ScrollView{
                vendorInfoView
                servedBrandsView
                imagesView
                vendorDetailsView
                countryAndCityView
            }
            buttonsView
        }
    }
    
    private var vendorInfoView: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                RemoteImageView(imageUrl: viewModel.vendorModel?.logo?.path ?? "")
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                Text(viewModel.vendorModel?.tradeName ?? "")
                    .font(addFont(fontType: .bold, size: 18))
                    .foregroundStyle(Color.CBlack)

                Spacer()

                favouriteButton
            }

            HStack(spacing: 6) {
                CustomStarRatingView(rating: rating, startSize: $starSize, paddingValue: $starPadding)
                Text(String(format: "%.1f", rating))
                    .font(addFont(fontType: .bold, size: 15))
                    .foregroundStyle(Color.CBlack)
            }

            ratingButton
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
        .padding(.horizontal)
    }

    private var ratingButton: some View {
        CustomeButtonWithBorderColor(title: "Show Ratings List".localized) {
            goRating = true
        }
    }

    @ViewBuilder
    private var servedBrandsView: some View {
        if let brands = viewModel.vendorModel?.servedBrands, !brands.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                TitleLabel(title: "brands_served".localized)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(brands, id: \.id) { brand in
                            HStack(spacing: 5) {
                                RemoteImageView(imageUrl: brand.logo?.path ?? "")
                                    .frame(width: 32, height: 32)
                                Text(brand.name ?? "")
                                    .font(addFont(fontType: .Regular, size: 13))
                                    .foregroundStyle(Color.CGray2)
                            }
                            .padding(.horizontal, 9)
                            .padding(.vertical, 6)
                            .background(Capsule().fill(Color.CGray4))
                        }
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
        }
    }

    private var favouriteButton: some View {
        Image(systemName: (viewModel.vendorModel?.isFavorite ?? false) ? "heart.fill" : "heart")
            .font(.system(size: 22))
            .foregroundStyle( viewModel.vendorModel?.isFavorite ?? false ? Color.CRed : Color.CGray2)
            .onTapGesture {
                if isLogin {
                    viewModel.handleFavourite(vendorId: viewModel.vendorId)
                }else {
                    showLoginPopup = true
                }

            }
        //                                .onChange(of: //favouritViewModel.isFavourit ?? false) { oldValue, newValue in
        //                                    isFavourit = newValue
        //                                }

    }
    
    @ViewBuilder
    private var imagesView: some View {
        HStack {
            Spacer()
            if let image = currentImage {
                RemoteImageView(imageUrl: image)
                    .frame(width: 160, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.bottom,10)
            } else if (viewModel.vendorModel?.images?.isEmpty ?? true) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.CGray4)
                    .frame(width: 160, height: 160)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 30))
                            .foregroundStyle(Color.CGray2)
                    )
                    .padding(.bottom,10)
            }
            Spacer()
        }
        HorizontalImageScroller(images: viewModel.vendorModel?.images ?? [], currentImage: $currentImage)
    }

    @ViewBuilder
    private var vendorDetailsView: some View {
        VStack(spacing: 12) {
            TitleLabel(title: "About Vendor".localized)

            Text(viewModel.vendorModel?.description ?? "")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(minHeight: 90)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.CWhite)
                )
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)

        }.padding()

    }


    private var countryAndCityView: some View {
        VStack(alignment: .trailing, spacing: 10) {
            if let country = viewModel.vendorModel?.country?.name, !country.isEmpty {
                Text(country)
                    .font(addFont(fontType: .bold, size: 15))
                    .foregroundStyle(Color.CBlack)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            if let city = viewModel.vendorModel?.city?.name, !city.isEmpty {
                Text(city)
                    .font(addFont(fontType: .Regular, size: 14))
                    .foregroundStyle(Color.CGray2)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            distanceView
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.CWhite)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 3)
        .padding(.horizontal)
    }

@ViewBuilder
private var distanceView: some View {
    Button {
        viewModel.openGoogleMaps(
            lat: viewModel.vendorModel?.latitude ?? 0.0,
            lng: viewModel.vendorModel?.longitude ?? 0.0
        )
    } label: {
        HStack(spacing: 6) {
            Image.darkLocation
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
            Text("distance_between_vendor_customer".localized)
                .font(addFont(fontType: .bold, size: 14))
                .foregroundStyle(Color.MainColor)
            Spacer()
            Image(systemName: "chevron.left")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(Color.MainColor)
        }
        .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
    .frame(maxWidth: .infinity, alignment: .leading)
}

    @ViewBuilder
    private var buttonsView: some View {
        HStack(spacing: 12) {

            CustomButtonWithIcon(action: {
                viewModel.openGoogleMaps(lat: viewModel.vendorModel?.latitude ?? 0.0, lng: viewModel.vendorModel?.longitude ?? 0.0)
            }, title: "Show Location".localized)

            CustomeButtonWithBorderColor(title: "create_order".localized) {
                if isLogin {
                    viewModel.coordinator.createOrder(mainOrderType: .custom, specificVendor: viewModel.vendorModel)
                }else {
                  showLoginPopup = true
                }

            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)

    }
    
    @ViewBuilder
    private var handleNavigation: some View {
        NavigationLink("",
                       destination: RatingsView(viewModel: RatingViewModel(traderId: viewModel.vendorId)), isActive: $goRating)
        .navigationBarHidden(true)
        .hidden()
        
    }
}





struct CustomButtonWithIcon: View {
    var action: () -> Void
    var title: String
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 16){
                Spacer()
                Text(title.localized)
                    .foregroundStyle(.white)
                    .font(.custom(AppFont.bold.rawValue, size: 16))
                
                Image.location
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 35)
                    .font(.custom(AppFont.bold.rawValue, size: 16))
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.MainColor)
            )
            
        }
    }
}
