import SwiftUI

struct ChooseAdTypeView: View {

    @Binding var navigateToCarAuctions: Bool
    @Binding var navigateToCustomAd: Bool
    @Binding var isPresented: Bool

    var body: some View {
        VStack (spacing: 20){
            ZStack {
                Text("choose_ad_type".localized)
                    .font(addFont(fontType: .Medium, size: 20))

                HStack {
                    Image(systemName: "xmark")
                        .font(.system(size: 30))
                        .onTapGesture {
                            isPresented = false
                        }
                    Spacer()
                }
            }
            .padding(.bottom)

            Button {
                isPresented = false
                navigateToCarAuctions = true
            } label: {
                Text("car_auction".localized)
                    .foregroundStyle(.cBlack)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.cGray3.opacity(0.7))
                    )
                    
            }

            Button {
                isPresented = false
                navigateToCustomAd = true
            } label: {
                Text("other_sections".localized)
                    .foregroundStyle(.cBlack)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.cGray3.opacity(0.7))
                    )
            }
        }
        .padding(.horizontal)
        .ignoresSafeArea()
    }
}
#Preview {
    ChooseAdTypeView(navigateToCarAuctions: .constant(false), navigateToCustomAd: .constant(false), isPresented: .constant(false))
}

