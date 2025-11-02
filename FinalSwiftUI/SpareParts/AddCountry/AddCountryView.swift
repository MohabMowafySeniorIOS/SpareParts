//
//  AddCountryView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 16/07/2025.
//

import SwiftUI

struct AddCountryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCountryDropDownActive: Bool = false
    @State private var isCityDropDownActive: Bool = false
    @State private var isRegionDropDownActive: Bool = false
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
                DropDownBar(isDropDownActive: $isCountryDropDownActive, title: "country")
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
                
                DropDownBar(isDropDownActive: $isCityDropDownActive, title: "city")
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
                
                DropDownBar(isDropDownActive: $isRegionDropDownActive, title: "region")
                    .onTapGesture {
                        isRegionDropDownActive.toggle()
                    }
                
                if isRegionDropDownActive {
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
                    SimpleSpareButton(buttonTitle: "add", action: {
                        
                    }, widthValue: 300, heightValue: 45)
                }
                .padding(.horizontal)
                .padding(.top)

            }
        }

        
    }
}

#Preview {
    AddCountryView()
}


