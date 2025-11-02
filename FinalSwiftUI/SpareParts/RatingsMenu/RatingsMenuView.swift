//
//  RatingsMenuView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 15/07/2025.
//

import SwiftUI

struct RatingsMenuView: View {
    @Environment(\.dismiss) var dismiss
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
            NormalAppBar(title: "ratings_menu") {
                dismiss()
            }
            ScrollView(showsIndicators: false){
                LazyVStack{
                    ForEach(0..<10) { item in
                        RatingsMenuCardView()
                    }
                }
            }
        }

    }
}

#Preview {
    RatingsMenuView()
}
