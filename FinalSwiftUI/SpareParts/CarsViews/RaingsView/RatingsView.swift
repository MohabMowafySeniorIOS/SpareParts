//
//  RatingsView.swift
//  MyAuctions
//
//  Created by Moaaz on 07/07/2025.
//

import SwiftUI


struct RatingsView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = RatingViewModel()

    var body: some View {
        VStack(spacing: 0) {
            AppHeaderView(Title: "ratings_menu") {
                dismiss()
            }
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(viewModel.ratings.indices, id: \.self) { index in
                        RatingSingleCardView(card: viewModel.ratings[index], index: index)
                    }
                }
               
            }
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
    }
}

#Preview {
    RatingsView()
}

