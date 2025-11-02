import SwiftUI

struct ContactInfoTabView: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack (spacing:20){
            ZStack {
                Text("contact_us".localized)
                    .font(addFont(fontType: .Medium, size: 16))

                HStack {
                    Image(systemName: "xmark")
                        .font(.system(size: 25))
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                }
            }
            .padding()

            HStack{
                Text("966501198")
                
                Image(systemName: "phone.fill")
                    .foregroundStyle(.main.opacity(0.7))
                    .font(.system(size: 25))
            }

            HStack{
                Text("moaza134" + "@gmail.com")
                    .foregroundStyle(.cBlack)
                
                Image(systemName: "envelope.fill")
                    .foregroundStyle(.main.opacity(0.7))
                    .font(.system(size: 25))
            }
            Button {
                
            } label: {
                HStack{
                    Spacer()
                    Text("contact".localized)
                        .foregroundStyle(.cWhite)
                    
                    Image(systemName: "envelope.fill")
                        .foregroundStyle(.cWhite)
                        .font(.system(size: 25))
                    Spacer()
                }
                .padding(.vertical,10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.main)
                )
                .padding(.horizontal,50)
            }

        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContactInfoTabView()
}
