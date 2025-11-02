import SwiftUI

enum transActionTypes {
    case deposit
    case withdrawal
    case fee_payment
    case fee_refund
    case commission
}



struct WalletMainView: View {
    
    enum walletTab {
        case addition, usage
    }
    
    @State var selectedTab: walletTab = .addition
    @State var walletMoneyField: String = ""
    @State var naviToChargeWallet: Bool = false
    
    @StateObject private var viewModel = WalletViewModel()
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
        .onAppear {
            viewModel.getTransActions(type: "deposit", page: "1")
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
            ZStack{
                NavigationLink("", destination: ChargeWalletView(), isActive: $naviToChargeWallet)
                VStack {
                    ZStack {
                        Text("wallet".localized.capitalized)
                            .foregroundStyle(.cWhite)
                            .font(.system(size: 20))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.main)
                    
                    HStack {
                        //add_balance
                        //naviToChargeWallet = true
                        ContentButtonView(title: "add_balance") {
                            naviToChargeWallet = true
                        }
                        
                        HStack {
                            TextField("cash".localized, text: $walletMoneyField)
                                .keyboardType(.numberPad)
                                .padding(13)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(style: StrokeStyle())
                                        .fill(.cGray1)
                                )
                                .padding(.leading, 7)
                            
                            Image(systemName: "globe")
                                .foregroundStyle(.main)
                                .font(.system(size: 30))
                        }
                    }
                    .padding(.horizontal, 7)
                    .padding(.vertical, 5)
                    .padding(7)
                    
                    HStack {
                        Text("addition".localized.capitalized)
                            .foregroundStyle(
                                selectedTab == .addition ? .cWhite : .main
                            )
                            .padding(10)
                            .padding(.horizontal)
                            .background(selectedTab == .addition ? .main : .cWhite)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedTab = .addition
                            }
                        
                        Text("usage".localized.capitalized)
                            .foregroundStyle(
                                selectedTab == .usage ? .cWhite : .main
                            )
                            .padding(10)
                            .padding(.horizontal)
                            .background(selectedTab == .usage ? .main : .cWhite)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedTab = .usage
                            }
                    }
                    .padding(7)
                    .padding(.horizontal, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle())
                            .fill(.main)
                    )
                    .padding(.vertical, 7)
                    
                    ScrollView {
                        
                        ForEach(viewModel.walletModel.indices, id: \.self) { index in
                            let item = viewModel.walletModel[index]
                            let bgColor = (index % 2 == 0) ? Color.cGray3.opacity(0.2) : Color.clear
                            WalletBlockItem(
                                item: item,
                                bgColor: bgColor
                           //     bgColor: bgColor
                            )
                        }
                        
                    }
                    
                }
            }
        }
    }
}

#Preview {
    WalletMainView()
}

