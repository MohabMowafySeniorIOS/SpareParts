//
//  ChatView.swift
//  FinalSwiftUI
//
//  Created by Mohab on 17/05/2025.
//

import SwiftUI
struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            
            AppHeaderView(Title: viewModel.Worker_name) {
                               dismiss()
                           }

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.messages) { msg in
                            HStack {
                                if msg.myId == viewModel.My_id {
                                    Spacer()
                                    Text(msg.msg)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                } else {
                                    Text(msg.msg)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                    Spacer()
                                }
                            }
                            .id(msg.id)
                        }
                    }
                    .padding(.horizontal)
                }
                .onChange(of: viewModel.messages.count) { _ in
                    if let last = viewModel.messages.last?.id {
                        proxy.scrollTo(last, anchor: .bottom)
                    }
                }
            }

            HStack {
                TextField("Send Message", text: $viewModel.messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    viewModel.sendMessage()
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}
