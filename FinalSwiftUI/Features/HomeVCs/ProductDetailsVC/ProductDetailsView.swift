import SwiftUI

struct ProductDetailsModel: Identifiable {
    var id = UUID()
    var productName: String
    var productImage: [Image]
    var vendorImage: Image
    var vendorName: String
    var city: String
    var date: String
    var description: String
    var price: String
    var isFavourite: Bool
}

struct ProductDetailsView: View {

    @State var productDetailsContent: ProductDetailsModel =
        ProductDetailsModel(
            productName: "toyota fortuner 2020",
            productImage: [
                Image(.image2), Image(.car), Image(.car), Image(.car),
            ], vendorImage: Image(.portraitWhiteManIsolated),
            vendorName: "moaz ahmed", city: "mansoura", date: "9/5/1998",
            description:
                "i'm done having such bad days i need to go out and kill someone so i can feel freedom i know it's weird but whatelse can someone who rly had enough do",
            price: "200 sr", isFavourite: false)

    @Environment(\.dismiss) var dismiss
    @State var tabSelection: Int = 0
    @State var isSheetPresented: Bool = false

    @State private var isImageClicked = false
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State var isFavourite: Bool = false

    @StateObject private var viewModel = ProductDetailsViewModel()
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
        NavigationStack {
            AppHeaderView(Title: "details", action: { dismiss() })
                .padding(.bottom)
            ScrollView {
                VStack {
                    HStack {
                        FavouriteImageButton(isFavourite: $isFavourite)
                        .onTapGesture {
                            productDetailsContent.isFavourite.toggle()
                            isFavourite.toggle()
                        }
                        Spacer()
                        Text(productDetailsContent.productName)
                    }
                    TabView(selection: $tabSelection) {
                        ForEach(
                            0..<productDetailsContent.productImage.count,
                            id: \.self
                        ) { index in
                            productDetailsContent.productImage[index]
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .tag(index)
                                .onTapGesture {
                                    isImageClicked.toggle()
                                }
                        }
                        .sheet(isPresented: $isImageClicked) {
                            ZoomableImageView(
                                scale: $scale,
                                image: productDetailsContent.productImage[tabSelection]
                            )
                            .presentationBackground(.black.opacity(0.3))
                        }

                    }
                    .frame(height: 200)
                    .cornerRadius(15)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                    HStack {
                        ForEach(
                            0..<productDetailsContent.productImage.count,
                            id: \.self
                        ) { index in
                            Circle()
                                .fill(index == tabSelection ? .main : .cGray3)
                                .frame(width: 10, height: 10)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            productDetailsContent.vendorImage
                            Text(productDetailsContent.vendorName)
                            Spacer()
                        }
                        .padding(.bottom)
                        HStack(spacing: 10) {
                            Image(systemName: "map")
                                .foregroundStyle(.main)

                            Text(productDetailsContent.city)
                                .foregroundStyle(.cBlack)
                                .font(.headline)
                            Spacer()
                            Image(systemName: "clock")
                                .foregroundStyle(.main)

                            Text(productDetailsContent.date)
                                .foregroundStyle(.cGray1)
                        }
                    }
                    .padding(.vertical)

                    Text(productDetailsContent.description)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)

                    HStack {
                        Image(systemName: "dollarsign.square.fill")
                            .foregroundStyle(.main)
                            .font(.system(size: 25))

                        Text(productDetailsContent.price)
                            .foregroundStyle(.cBlack)
                            .font(.headline)
                    }
                    .padding(.bottom)

                    ContentButtonView(title: "show_contact_info".localized) {
                        isSheetPresented.toggle()
                    }
                    .padding(.horizontal,25)
                    .sheet(
                        isPresented: $isSheetPresented,
                        content: {
                            ContactInfoTabView()
                                .presentationDetents([.height(250)])
                        })

                }
                .padding(.horizontal)
            }.navigationBarBackButtonHidden()

        }
    }
}


#Preview {
    ProductDetailsView()
}
