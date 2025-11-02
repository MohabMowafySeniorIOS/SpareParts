import Foundation
import SwiftUI


struct CarAuctionDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var tabSelection: Int = 0
    @State var isFavourite: Bool = false
    
    @State private var productDetails: CarAuctionsDetailsModel =
    CarAuctionsDetailsModel(productName: "toyouta fortuner 2020",isFavourite: false,productImages: [Image(.car), Image(.car), Image(.car), Image(.car)], profileImage: Image.profileImage, profileName: "vendor name", city: "riyadh", address: "shemisy", publishDate: "1/1/2090", startDate: "1/1/2090", endDate: "1/1/2090", describtion: "This is a sample description text created by devs which can be replaced by actual description of the product provided by the api", currentPrice: "100", startingPrice: "200", remainingTime: "1 ms")
    
    var body: some View {
        NavigationStack{
            AppHeaderView(Title:"details", action: {dismiss()})
                .padding(.bottom)
            ScrollView{
                VStack{
                    HStack{
                        Text(productDetails.productName.localized)
                        Spacer()
                        FavouriteImageButton(isFavourite: $isFavourite)
                            .onTapGesture {
                                isFavourite.toggle()
                            }
                    }
                    
                    AuctionImageSlider(tabSelection: $tabSelection, productDetails: $productDetails)
                        
                    HStack(spacing: 15){
                        productDetails.profileImage
                        Text(productDetails.profileName)
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    HStack(spacing: 15){
                        VStack(alignment:.leading,spacing: 12){
                            TitleText(title: "city")
                            TitleText(title: "address")
                            TitleText(title: "publish_date")
                            TitleText(title: "start_day_and_date")
                            TitleText(title: "end_day_and_date")
                        }
                        VStack(alignment:.leading,spacing: 12){
                            Text(productDetails.city)
                                .foregroundStyle(.cGray1)
                            
                            Text(productDetails.address)
                                .foregroundStyle(.cGray1)
                            
                            Text(productDetails.publishDate)
                                .foregroundStyle(.cGray1)
                            
                            Text(productDetails.startDate)
                                .foregroundStyle(.cGray1)
                            
                            Text(productDetails.endDate)
                                .foregroundStyle(.cGray1)
                        }
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    Text(productDetails.describtion)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                    
                    NavigationLink(destination: CarDetailsAsTextView()) {
                        HStack{
                            Text("car_details".localized)
                                .foregroundStyle(.cBlack)
                            Spacer()
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.main)
                                .font(.system(size: 20))
                        }
                        .padding(13)
                        .background(.cGray3.opacity(0.4))
                        .cornerRadius(5)
                        .padding(.bottom)
                    }
                    
                    HStack{
                        Spacer()
                        Image(systemName: "dollarsign.circle")
                            .font(.system(size: 25))
                            .foregroundStyle(.cBlack)
                        Text("current_price".localized)
                            .font(addFont(fontType: .Regular, size: 17))
                        Text(productDetails.currentPrice + "sr".localized)
                            .font(addFont(fontType: .Medium, size: 17))
                        Spacer()
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle())
                            .fill(.main.opacity(0.7))
                    )
                    .padding(.bottom)
                    
                    HStack{
                        VStack(spacing:10){
                            HStack{
                                Spacer()
                                
                                Image(systemName: "dollarsign.circle")
                                    .foregroundStyle(.main.opacity(0.7))
                                    .font(.system(size: 25))
                                
                                Text("starting_price".localized)
                                    .foregroundStyle(.main.opacity(0.7))
                                
                                Spacer()
                            }
                            Text(productDetails.startingPrice + " " + "sr".localized)
                        }
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle())
                                .fill(.main.opacity(0.7))
                        )
                        Spacer()
                        VStack(spacing:10){
                            HStack{
                                Spacer()
                                
                                Image(systemName: "clock")
                                    .foregroundStyle(.main.opacity(0.7))
                                    .font(.system(size: 25))
                                
                                Text("remaining_time".localized)
                                    .foregroundStyle(.main.opacity(0.7))
                                
                                Spacer()
                            }
                            Text(productDetails.remainingTime)
                        }
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(style: StrokeStyle())
                                .fill(.main.opacity(0.7))
                        )

                    }
                    
                    //"subscribe"
                    ContentButtonView(title: "subscribe".localized) {
                        
                    }
                    .padding(.horizontal,25)
                    .padding(.vertical)
                    
                }
                .padding(.horizontal)
            }.navigationBarBackButtonHidden()

        }    }
}

#Preview {
    CarAuctionDetailsView()
}

private struct TitleText: View {
    
    var title: String
    
    var body: some View {
        Text(title.localized)
            .foregroundStyle(.cBlack)
            .font(.headline)
    }
}

struct AuctionImageSlider: View {
    
    @Binding var tabSelection: Int
    @Binding var productDetails: CarAuctionsDetailsModel
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ForEach(0..<productDetails.productImages.count, id: \.self) { index in
                productDetails.productImages[index]
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(height:180)
                    .cornerRadius(15)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height:180)
        
        HStack(spacing: 8){
            ForEach(0..<productDetails.productImages.count, id: \.self) { index in
                Circle()
                    .fill(index == tabSelection ? .main : .clear)
                    .frame(width: 12, height: 12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle())
                        .fill(Color.cBlack.opacity(0.7))
                    )
            }
        }
    }
}
