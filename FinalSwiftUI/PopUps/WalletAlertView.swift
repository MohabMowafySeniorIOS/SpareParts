import SwiftUI

// MARK: - Custom Alert: Insufficient Balance

struct InsufficientBalanceAlert: View {
   // var onAddBalance: () -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            Text("insufficient_balance_title".localized)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)

            Text("insufficient_balance_message".localized)
                .font(.system(size: 15))
                .foregroundColor(.black.opacity(0.75))
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .fixedSize(horizontal: false, vertical: true)

            Divider()
                .padding(.top, 4)

            HStack(spacing: 24) {
                Button(action: onCancel) {
                    Text("insufficient_balance_cancel_button".localized)
                        .font(.system(size: 16))
                        .foregroundColor(.MainColor)
                }

//                Button(action: onAddBalance) {
//                    Text("insufficient_balance_add_button".localized)
//                        .font(.system(size: 16, weight: .medium))
//                        .foregroundColor(.MainColor)
//                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemBackground))
        )
        .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 8)
        .padding(.horizontal, 32)
        .environment(\.layoutDirection,appLanguage == "en" ? .leftToRight : .rightToLeft)
    }
}

// MARK: - Modifier to present it like a system alert overlay

struct InsufficientBalanceOverlay: ViewModifier {
    @Binding var isPresented: Bool
    var onAddBalance: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture { isPresented = false }
                    .transition(.opacity)

                InsufficientBalanceAlert(
//                    onAddBalance: {
//                        isPresented = false
//                        onAddBalance()
//                    },
                    onCancel: {
                        isPresented = false
                    }
                )
                .transition(.scale(scale: 0.9).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isPresented)
    }
}

extension View {
    func insufficientBalanceAlert(isPresented: Binding<Bool>, onAddBalance: @escaping () -> Void) -> some View {
        modifier(InsufficientBalanceOverlay(isPresented: isPresented, onAddBalance: onAddBalance))
    }
}

// MARK: - Demo / Preview usage

struct InsufficientBalanceDemo: View {
    @State private var showAlert = true
    @State private var showChargePopup = false
    var body: some View {
        VStack {
            Button("إظهار التنبيه") {
                showAlert = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .insufficientBalanceAlert(isPresented: $showAlert) {
            
//                ChargeWalletPopupView(
//                    showPopup: $showChargePopup,
//                    chargeState: .idle
//                ) { amount in
//                    viewModel.chargeWallet(amount: amount)
//                }
          
            print("Navigate to top-up flow")
        }
    }
}

#Preview {
    InsufficientBalanceDemo()
}
