//
//  VendorDetailsView.swift
//  MyAuctions
//
//  Created by Moaaz on 14/07/2025.
//

import SwiftUI

struct VendorDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var rating: Double = 4.5
    @State var starSize: CGFloat = 20
    @State var starPadding: CGFloat = 3
    @State var tabSelection: Int = 0
    @StateObject private var viewModel = VendorDetailsViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    @State var currentImage: Image?
    
    @State var images: [Image] = [
        Image(.car),
        Image(.image2),
        Image(.KSA),
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
        }
        .onAppear {
            
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
            VStack{
                NormalAppBar(title: "vendor_details") {
                    dismiss()
                }
                ScrollView{
                    VStack(spacing:10){
                        HStack(alignment: .top){
                            HStack(alignment:.top){
                                Image(.portraitWhiteManIsolated)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.main, lineWidth: 2)
                                    )
                                    .padding(.trailing)
                                VStack(alignment: .leading, spacing:15){
                                    Text("vendor_name".localized)
                                        .foregroundStyle(.main)
                                    
                                    HStack{
                                        Text(String(rating))
                                            .foregroundStyle(.main)
                                            .padding(.trailing,10)
                                        
                                        CustomStarRatingView(rating: $rating, startSize: $starSize, paddingValue: $starPadding)
                                    }
                                SmallButtonComponent(action: {
                                    
                                }, title: "show_ratings_menu")
                            }
                                Spacer()
                                }
                            
                            Spacer()
                            Image(systemName: "heart.fill")
                                .font(.system(size: 30))
                                .foregroundStyle(.cRed)
                        }
                        .padding()
                        
                        if let image = currentImage {
                            currentImage?
                                .resizable()
                                .frame(width: 200, height: 200)
                                .clipped()
                                .cornerRadius(8)
                                .padding(.bottom,10)
                        }else{
                            
                        }
                        HorizontalImageScroller(images: images, currentImage: $currentImage)
                        TitleLabel(title: "vendor_details_title")
                            .padding()
                        
                        Text("we mark a class ObservableObject so that when a @published var state changes inside the class the view that has an object from that class updates automatically ")
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(style: StrokeStyle())
                                    .fill(.cGray1)
                            )
                            .padding(.horizontal)
                        DoubleHTitleLabel(head: "city", tail: "saudi arabia")
                            .padding(.horizontal)
                        DoubleHTitleLabel(head: "city", tail: "riyadh")
                            .padding(.horizontal)
                        HStack{
                            Text("distance_between_vendor_customer")
                            Image.darkLocation
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        CustomButtonWithIcon(action: {
                            
                        }, title: "show_location")
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .padding(.top)

                        
                        CustomeButtonWithBorderColor(title: "create_order".localized) {
                            
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding(.horizontal)
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    VendorDetailsView(currentImage: Image(.car))
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
                    .foregroundStyle(.cWhite)
                
                Image.location
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 35)
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(.main)
            )
            
        }
    }
}
