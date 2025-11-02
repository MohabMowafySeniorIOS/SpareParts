import SwiftUI

enum FavouritesSectionButtons{
    case ads
    case auctions
}

struct FavouritesView: View {
    @State var isNavi: Bool = false
    @State var searchText: String = ""

    @StateObject private var viewModel = FavouriteViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    @State private var section: FavouritesSectionButtons = .ads

    var body: some View {
        ZStack {
            errorToast
            if viewModel.isLoading == true {
                LoaderView(rotation: $rotation, isLoading: $isLoading)
                    .frame(width: 100, height: 100)
            } else {
                mainContent
            }
        }.onAppear {
            viewModel.getFavourite()
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
            
            PlainAppHeaderView(title: "favourites")
            
            VStack {
                HStack {
                    FavouritesSectionButton(isSelected: $section, sectionType: .auctions, buttonName: "auctions")
                    FavouritesSectionButton(isSelected: $section, sectionType: .ads, buttonName: "advertisements")
                }
                .padding(7)
                .padding(.horizontal,10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(style: StrokeStyle())
                        .fill(.main.opacity(0.8))
                )
                .padding(.vertical)

                ScrollView {
                    if section == .ads {
                        ForEach(viewModel.favouritesData.indices , id: \.self) { index in
                            var item = viewModel.favouritesData[index]
                            
                            FavouritesCard(item: item)

    //                        .fullScreenCover(
    //                            isPresented: $isNavi,
    //                            content: { ProductDetailsView() }
    //                        )
                        }
                        
                    }else{
                        ForEach(viewModel.favouritesData.indices , id: \.self) { index in
                            var item = viewModel.favouritesData[index]
                            
                            FavouritesCard(item: item)

    //                        .fullScreenCover(
    //                            isPresented: $isNavi,
    //                            content: { ProductDetailsView() }
    //                        )
                        }
                    }

                }
                .statusBarHidden()
            }
        }
    }
}

#Preview {
    FavouritesView()
}

struct FavouritesSectionButton: View {
    @Binding var isSelected: FavouritesSectionButtons
    var sectionType: FavouritesSectionButtons
    var buttonName: String
    
    var body: some View {
        Text(buttonName.localized)
            .font(addFont(fontType: .Medium, size: 17))
            .foregroundStyle(isSelected == sectionType ? Color.cWhite : Color.main.opacity(0.8))
            .padding(7)
            .padding(.horizontal)
            .background(
                isSelected == sectionType ? Color.main.opacity(0.7) : Color.cWhite
            )
            .cornerRadius(10)
            .onTapGesture {
                isSelected = sectionType
            }
            .padding(.trailing,7)
    }
}
