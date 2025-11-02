//
//  MyAuctions
//
//  Created by Moaaz on 10/07/2025.
//

import SwiftUI

struct VendorssecondView: View {
    @Environment(\.dismiss) var dismiss
    @State private var fieldText: String = ""
    @StateObject private var viewModel = VendorDetailsViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    @State var isVendorMenu: Bool = false
    @State private var navToOrderNow: Bool = false
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
//        .ignoresSafeArea()
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
        
         NavigationStack{
            VStack{
                NormalAppBar(title: "vendors_menu") {
                    dismiss()
                }
                HomeSearchBar(searchFieldText: $fieldText)
                    .padding(.horizontal)
                HStack{
                    Spacer()

                    Image(systemName: "list.bullet")
                        .foregroundStyle(.cBlack)
                        .font(.system(size: 25))
                        .onTapGesture {
                            isVendorMenu = true
                        }
                        .sheet(isPresented: $isVendorMenu) {
                            VendorsMenuFilterCardView()
                                .presentationDetents([.height(310)])
                        }

                    
                    Image(systemName: "slider.horizontal.3")
                        .foregroundStyle(.cBlack)
                        .font(.system(size: 25))
                }
                .padding(.horizontal)
                
                ScrollView(showsIndicators: false){
                    LazyVGrid(
                        columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                        ForEach(0..<10){_ in
                            VendorCardWithLocation(rating: .constant(3.5))
                            }
                        .frame(maxWidth: 150)
                    }
                }
                .padding(.top)
                .padding(.horizontal, 12)
            }
        }
//         .ignoresSafeArea()
        
    }
}

#Preview {
    VendorssecondView()
}


