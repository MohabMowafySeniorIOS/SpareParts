//
//  ContentView.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 27/11/2024.
//

import SwiftUI

struct ContactUSView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var isValid: Bool = true

    
    @StateObject private var viewModel = contactUsViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    
    @State private var selectedType: MessageType = .suggestion
    @State private var messageInput: String = ""
    @State private var messageBody: String = ""
    
    @State private var isOpened: Bool = true
    @State private var isComplain: Bool = false
    
    @State var vv: String = ""
    

    var body: some View {
        AppHeaderView(Title: "menu_cancellation".localized) {
            dismiss()
        }
        VStack(alignment: .trailing, spacing: 16) {
            // Header
            
           
            ZStack {
                errorToast
                successToastAlert
               
                if viewModel.isLoading == true {
                    LoaderView(rotation: $rotation, isLoading: $isLoading)
                        .frame(width: 100, height: 100)
                } else {
                    mainContent
                }
            }
            .onReceive(viewModel.$contactModel) { Model in
                guard let Model = Model else { return }
            
            }


          
        }
        
        .navigationBarHidden(true)
    }
    
    
    @ViewBuilder
    private var errorToast: some View {
        if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
            ToastView(message: errorMessage, backgroundColor: .red)
                .transition(.move(edge: .top))
                .zIndex(1)
        }
    }
    
    @ViewBuilder
    private var successToastAlert: some View {
        if let errorMessage = viewModel.contactModel?.message, !errorMessage.isEmpty {
            ToastView(message: errorMessage, backgroundColor: .green)
                .transition(.move(edge: .top))
                .zIndex(1)
        }
    }
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        ScrollView {
            VStack(alignment: .trailing, spacing: 16) {
                
                HStack {
                    Text("Message_Type".localized)
                        .font(addFont(fontType: .Medium, size: 12))
                    Spacer()
                }
              
                    
                
                HStack(spacing: 16) {
                    SelectedCustomView(isSelected: $isOpened, title: "Opened".localized) {
                        isOpened = true
                        isComplain = false
                    }
                    
                    SelectedCustomView(isSelected: $isComplain, title: "Complaint".localized) {
                        isComplain = true
                        isOpened = false
                        
                    }
                }
                
                VStack(alignment: .trailing, spacing: 8) {
                    CustomTextField(text: $messageInput, Validation_label: $vv, is_validation_label: $isValid, is_title_label: true, textType: .messageType)
                }
                
                VStack(alignment: .trailing, spacing: 8) {
                    HStack {
                        Text("Message_Text".localized)
                            .font(addFont(fontType: .Medium, size: 12))
                        Spacer()
                    }
                  
                    TextEditor(text: $messageBody)
                        .frame(height: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                }
                
                ContentButtonView(title: "send".localized) {
                    viewModel.sendMessage(parameters: .init(message_type: selectedType == .suggestion ? "suggestion" : "complaint",subject: messageInput,message: messageBody))
                }
            }
            .padding()
        }
    }
}

enum MessageType {
    case suggestion, complaint
}


#Preview {
    ContactUSView()
}
