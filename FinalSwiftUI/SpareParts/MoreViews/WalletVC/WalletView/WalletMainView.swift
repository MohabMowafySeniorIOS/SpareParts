import SwiftUI

enum transActionTypes {
    case deposit
    case withdrawal
    case fee_payment
    case fee_refund
    case commission
}

enum walletTab {
    case addition
    case usage
    case withDrawRequest
}

struct WalletMainView: View {
    
   
    @State private var showReceipt = false
    @State private var showChargePopup = false
    @State private var transferImage: String?
    
    @State var selectedTab: walletTab = .addition
    @State var walletMoneyField: String = ""
    
    @ObservedObject private var viewModel: WalletViewModel
    init(viewModel: WalletViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
  
    var body: some View {
        ZStack {
                   
            mainContent
                .background(
                    Color(Color.backGroundColor)
                )
                   
            if showReceipt {
                ReceiptPopupView(
                    imageURL: transferImage ?? "",
                    showPopup: $showReceipt
                )
            }
            
            if showChargePopup {
                ChargeWalletPopupView(
                    showPopup: $showChargePopup,
                    chargeState: viewModel.chargeState
                ) { amount in
                    viewModel.chargeWallet(amount: amount)
                }
            }
            
            chargeStateOverlay
        }
          
        
    }
    
    
    // MARK: - Main Content
    
    private var mainContent: some View {
        
        VStack {
            headerView
            balanceView
            typesView
            ShowViewState(state: viewModel.state) { Model in
                scrollView
            }
            Spacer()
            
        }
        .overlay(alignment: .bottomLeading) {
            addBalanceFloatingButton
        }
        .onReceive(NotificationCenter.default.publisher(for: Foundation.Notification.Name.walletNeedsRefresh)) { _ in
            selectedTab = .addition
            viewModel.refreshWallet()
        }
        
    }
    
    private var headerView: some View {
        AppHeaderView(Title: "Wallet".localized) {
            viewModel.disMiss()
        }
    }
    
    private var balanceView: some View {
        HStack {
            HStack(spacing: 10) {
                Image("Wallet-1")
                    .resizable()
                    .foregroundStyle(Color.MainColor)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 18)
                    .padding(10)
                    .background(
                        Circle().fill(Color.CWhite)
                    )
                    .overlay(
                        Circle().stroke(Color.CGray2, lineWidth: 1)
                    )

                Text(viewModel.balanceModel?.formatted_balance ?? "")
                    .font(addFont(fontType: .bold, size: 16))
                    .foregroundStyle(Color.CBlack)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.CGray2, lineWidth: 1)
                    )
            }

            Spacer()

            ContentButtonView(title: "Withdrawal of balance".localized) {
                viewModel.coordinator.showWithDraw()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)

    }

    private var typesView: some View {
        HStack(spacing: 16) {
            Text("addition".localized.capitalized)
                .underline(selectedTab == .addition)
                .foregroundStyle(selectedTab == .addition ? Color.MainColor : Color.CBlack)
                .font(.custom(AppFont.bold.rawValue, size: 16))
                .onTapGesture {
                    selectedTab = .addition
                    viewModel.getAdditions(page: "1")
                }

            Text("usage".localized.capitalized)
                .underline(selectedTab == .usage)
                .foregroundStyle(selectedTab == .usage ? Color.MainColor : Color.CBlack)
                .font(.custom(AppFont.bold.rawValue, size: 16))
                .onTapGesture {
                    selectedTab = .usage
                    viewModel.getTransActions(type: "payment", page: "1")
                }

            Text("wallet.withdraw_request".localized.capitalized)
                .underline(selectedTab == .withDrawRequest)
                .foregroundStyle(selectedTab == .withDrawRequest ? Color.MainColor : Color.CBlack)
                .font(.custom(AppFont.bold.rawValue, size: 16))
                .onTapGesture {
                    selectedTab = .withDrawRequest
                    viewModel.getWithDraw(page: "1")
                }
        }
        .padding()



    }
    
    private var scrollView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.walletModel.indices, id: \.self) { index in
                    let item = viewModel.walletModel[index]
                    WalletBlockItem(
                        item: item,
                        itemIndex: index + 1,
                        selectedTab: $selectedTab,
                        banckDetailsTap: {
                            viewModel.coordinator.BanckAccountDetails(model: item)
                        },
                        imageTap: {
                            self.loadImage(urlString: item.transfer_image ?? "")

                        }
                    )
                    .onAppear {
                        viewModel.loadMoreIfNeeded(currentIndex: index)
                    }
                }
                
                if viewModel.canLoadMore {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
            }
            .padding(.horizontal)
            .padding(.top, 4)
        }
    }
    
    private var addBalanceFloatingButton: some View {
        Button {
            showChargePopup = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 32, weight: .regular))
                .foregroundColor(.white)
                .frame(width: 74, height: 74)
                .background(Color.MainColor)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.24), radius: 8, x: 0, y: 4)
        }
        .padding(.leading, 24)
        .padding(.bottom, 18)
    }
    
    @ViewBuilder
    private var chargeStateOverlay: some View {
        switch viewModel.chargeState {
        case .loading:
            Color.black.opacity(0.25)
                .ignoresSafeArea()
            LoaderView(rotation: .constant(0), isLoading: .constant(true))
                .frame(width: 90, height: 90)
        case .error(let message):
            VStack(spacing: 12) {
                Text(message)
                    .font(.custom(AppFont.Regular.rawValue, size: 15))
                    .foregroundColor(Color.CBlack)
                    .multilineTextAlignment(.center)
                
                Button {
                    viewModel.resetChargeState()
                } label: {
                    Text("Done".localized)
                        .font(.custom(AppFont.bold.rawValue, size: 16))
                        .foregroundColor(.white)
                        .frame(width: 120, height: 44)
                        .background(Color.MainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(24)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 40)
        default:
            EmptyView()
        }
    }
    
    func loadImage(urlString: String) {
        self.transferImage = urlString
        self.showReceipt = true
    }
}

struct ChargeWalletPopupView: View {
    @Binding var showPopup: Bool
    let chargeState: viewState<WalletChargeData?>
    let onConfirm: (Double) -> Void
    
    @State private var amount = ""
    @State private var showValidation = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.55)
                .ignoresSafeArea()
                .onTapGesture {
                    showPopup = false
                }
            
            VStack(alignment: .trailing, spacing: 22) {
                Text("add_balance".localized)
                    .font(.custom(AppFont.bold.rawValue, size: 23))
                    .foregroundColor(Color.CBlack)
                
                VStack(alignment: .trailing, spacing: 6) {
                    TextField("enter_amount".localized, text: $amount)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.custom(AppFont.Regular.rawValue, size: 18))
                        .padding(.horizontal, 18)
                        .frame(height: 58)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.CWhite)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.CGray1, lineWidth: 1.2)
                        )
                        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
                    
                    if showValidation {
                        Text("validation_required".localized)
                            .font(.custom(AppFont.Regular.rawValue, size: 12))
                            .foregroundColor(Color.CRed)
                    }
                }
                
                HStack(spacing: 24) {
                    Button {
                        showPopup = false
                    } label: {
                        Text("cancel".localized)
                            .font(.custom(AppFont.bold.rawValue, size: 18))
                            .foregroundColor(Color.CBlack)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                            .background(
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color.CGray1, lineWidth: 1.2)
                            )
                    }
                    
                    Button {
                        guard let amountValue = validAmount else {
                            showValidation = true
                            return
                        }
                        showValidation = false
                        showPopup = false
                        onConfirm(amountValue)
                    } label: {
                        Text("confirm".localized)
                            .font(.custom(AppFont.bold.rawValue, size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                            .background(Color.MainColor)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                }
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 34)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding(.horizontal, 24)
            
            if case .loading = chargeState {
                LoaderView(rotation: .constant(0), isLoading: .constant(true))
                    .frame(width: 90, height: 90)
            }
        }
        .environment(\.layoutDirection, appLanguage == "ar" ? .leftToRight : .rightToLeft)
    }
    
    private var validAmount: Double? {
        let normalizedAmount = amount.replacingOccurrences(of: ",", with: ".")
        guard let amountValue = Double(normalizedAmount), amountValue > 0 else {
            return nil
        }
        return amountValue
    }
}
