//
//  VendorCountryAndCityFilterView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 15/07/2025.
//

import SwiftUI

struct VendorCountryAndCityFilterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCountryDropDownActive: Bool = false
    @State private var isCityDropDownActive: Bool = false
    @StateObject private var viewModel = VendorDetailsViewModel()
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
        VStack{
            NormalAppBar(title: "filer") {
                dismiss()
            }
            ScrollView {
                HStack{
                    Text("country".localized)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isCountryDropDownActive ? 180 : 0))
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle())
                )
                .padding()
                .onTapGesture {
                    isCountryDropDownActive.toggle()
                }
                
                if isCountryDropDownActive {
                    VStack(alignment: .leading){
                        ForEach(0..<10) { item in
                            HStack{
                                SpareCityFilterBox(isBoxActive: false, city: "saui")
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                HStack{
                    Text("city".localized)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isCountryDropDownActive ? 180 : 0))
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle())
                )
                .padding()
                .onTapGesture {
                    isCityDropDownActive.toggle()
                }
                
                if isCityDropDownActive {
                    VStack(alignment: .leading){
                        ForEach(0..<10) { item in
                            HStack{
                                SpareCityFilterBox(isBoxActive: false, city: "saui")
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                HStack{
                    SmallButtonComponent(action: {
                        
                    }, title: "save")
                    Spacer()
                    SmallButtonWithBorder(action: {
                        
                    }, title: "reset")
                }
                .padding(.horizontal)
                .padding(.top)

            }
        }

        
    }
}

#Preview {
    VendorCountryAndCityFilterView()
}

