//
//  MyOrdersView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 18/07/2025.
//

import SwiftUI

enum MyOrderType: String, CaseIterable {
    case onProgress
    case running
    case expired
}

struct MyOrdersView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var selectedType: MyOrderType = .onProgress
    var body: some View {
        NavigationStack {
            VStack {
                NormalAppBar(title: "my_orders") {
                    dismiss()
                }
                HStack(spacing:20){
                    Text("on_progress".localized)
                        .underline(selectedType == .onProgress)
                        .foregroundStyle(selectedType == .onProgress ? .main : .cBlack)
                        .onTapGesture {
                            selectedType = .onProgress
                        }
                    
                    Text("running".localized)
                        .underline(selectedType == .running)
                        .foregroundStyle(selectedType == .running ? .main : .cBlack)
                        .onTapGesture {
                            selectedType = .running
                        }
                    
                    Text("expired".localized)
                        .underline(selectedType == .expired)
                        .foregroundStyle(selectedType == .expired ? .main : .cBlack)
                        .onTapGesture {
                            selectedType = .expired
                        }
                    
                }
                .padding(.vertical)
                
                ScrollView {
                    if selectedType == .onProgress {
                        ForEach(0..<5) { _ in
                            MyOrdersCardView()
                        }
                        .padding(.vertical,5)
                    }
                    
                    if selectedType == .running {
                        
                    }
                    
                    if selectedType == .expired {
                        ForEach(0..<5) { _ in
                            MyOrdersCardView()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MyOrdersView()
}


