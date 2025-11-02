//
//  MessageView.swift
//  FinalSwiftUI
//
//  Created by Mohab on 17/05/2025.
//

import SwiftUI

import SwiftUI

struct MessagesView: View {
    @StateObject private var viewModel = MessagesViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
           
                AppHeaderView(Title: "Messages".localized) {
                                   dismiss()
                               }

            List(viewModel.rooms) { room in
                VStack(alignment: .leading) {
                    Text(room.name ?? "")
                        .font(.headline)
                    Text(room.lastMsg ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(room.time ?? "")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationBarHidden(true)
    }
}
