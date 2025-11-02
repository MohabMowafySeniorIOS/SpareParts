//
//  FAQVC.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 19/12/2024.
//


import SwiftUI

struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct FAQScreen: View {
  
   
        @StateObject private var viewModel = FAQViewModel()
        @Environment(\.dismiss) var dismiss
        @State private var faqItems = [FAQ]()
        @State private var rotation: Double = 0
        @State private var isLoading = true
    var body: some View {
        AppHeaderView(Title: "FAQ".localized) {
                           dismiss()
                       }
       
            ZStack {
                errorToast
                if viewModel.isLoading == true {
                    LoaderView(rotation: $rotation, isLoading: $isLoading)
                        .frame(width: 100, height: 100)
                } else {
                    mainContent
                }
            } .onAppear() {
                viewModel.getFAQS(urlEndPoint: .settings_faq, methodType: .get)
            }
            .onReceive(viewModel.$ModelFAQ) { Model in
                guard let Model = Model else { return }
               faqItems = Model.faqs ?? []
                print(faqItems,Model.faqs ?? [])
           
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
                VStack(spacing: 12) {
                    ForEach($faqItems) { $item in
                        FAQRow(
                            item: $item
                           
                        )
                        .onTapGesture {
                            withAnimation {
                                item.isExpanded.toggle()
                            }
                        }
                    }
                }
                .padding([.top],16)
            }
        
    }
}

struct FAQRow: View {
   @Binding var item: FAQ
    

    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            HStack {
                Text(item.question)
                    .font(.body)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: item.isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)

            if item.isExpanded {
                HStack {
                    Text(item.answer)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(16)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    Spacer()
                }
               
            }
        }.background(Color(UIColor.systemGray6))
        .animation(.easeInOut(duration: 0.3), value: item.isExpanded)
        .cornerRadius(8)
        .padding(.horizontal)
      
    }
}

#Preview {
    FAQScreen()
}
