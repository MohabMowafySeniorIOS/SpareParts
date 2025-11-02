//
//  TermsView.swift
//  FinalSwiftUI
//
//  Created by Mohab on 17/05/2025.
//

import SwiftUI
enum TermsTyoe {
    case About
    case Terms
    case Privacy
    case Policy
}
struct TermsVC: View {
    @Environment(\.dismiss) var dismiss
    @State var itemType : TermsTyoe
    @State var pageTitle : String
    @StateObject private var viewModel = TermsViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    
     var body: some View {
         VStack {
             AppHeaderView(Title: pageTitle) {
                 dismiss()
             }
             Spacer()
                ZStack {
                    errorToast
                    if viewModel.isLoading == true {
                        LoaderView(rotation: $rotation, isLoading: $isLoading)
                            .frame(width: 100, height: 100)
                    } else {
                        mainContent
                    }
                }.onAppear(){
                    var urlEndPoint : EndPoints = .settings_terms
                    switch itemType {
                    case .About:
                        urlEndPoint = .settings_about
                    case .Terms:
                        urlEndPoint = .settings_terms
                    case .Privacy:
                        urlEndPoint = .settings_privacy
                    case .Policy:
                        urlEndPoint = .settings_privacy
                    }
                    viewModel.getTerms(urlEndPoint: urlEndPoint, methodType: .get, parameters: .init())
                }
             
             Spacer()
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
        
        ScrollView {
            
            VStack(spacing:16) {
                
                VStack(spacing: 16) {
                    Image.TermsImage
                   // HTMLWebView(htmlContent: viewModel.termsModel?.content ?? "")
                 Text((viewModel.termsModel?.content ?? ""))  .font(addFont(fontType: .Regular, size: 14))
                }.padding()
               
            }

        }
        
        .mask(RoundedRectangle(cornerRadius: 0))
       
    }
    
}

#Preview {
  //  TermsVC()
}
import SwiftUI
import WebKit

struct HTMLWebView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = true
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
