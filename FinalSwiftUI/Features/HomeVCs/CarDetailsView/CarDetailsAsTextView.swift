//
//  CarDetailsAsTextView.swift
//  Auctions
//
//  Created by Moaaz on 03/06/2025.
//

import SwiftUI

struct carDetails: Identifiable {
    let id = UUID()
    var title: String
    var des: String
}

struct CarDetailsAsTextView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CarDetailsAsTextViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true

    private var cardetails: [carDetails] = [
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
        carDetails(title: "brand", des: "toyouta"),
    ]

    var body: some View {
        AppHeaderView(Title: "details", action: { dismiss() })
        ZStack {
            errorToast
            if viewModel.isLoading == true {
                LoaderView(rotation: $rotation, isLoading: $isLoading)
                    .frame(width: 100, height: 100)
            } else {
                mainContent
            }
        }
        Spacer()
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

        ScrollView {
            VStack {
                ForEach(cardetails) { item in
                    DetailsBar(title: item.title, des: item.des)
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    CarDetailsAsTextView()
}
