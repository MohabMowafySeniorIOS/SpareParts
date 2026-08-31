//
//  ChoosePaymentWay.swift
//  SpareParts
//
//  Created by Mohab on 25/02/2026.
//

import SwiftUI

struct PaymentMethodsView: View {
    @State private var showAlert = false
    @ObservedObject var vm: PaymentVM
    init(vm: PaymentVM) {
        self._vm = ObservedObject(wrappedValue: vm)
    }

    var body: some View {
        VStack(spacing: 20) {
            AppHeaderView(Title: "Choose Payment Method".localized) {
                vm.disMiss()
            }
            
            ShowViewState(state: vm.state) { Model in
                scrollView
            }
            Spacer()
            paymnetButton
           

        } .insufficientBalanceAlert(isPresented: $showAlert) {
            print("Navigate to top-up flow")
        }
    }
    
   
    
    
    private var scrollView: some View {
        ScrollView {
            VStack(spacing: 12) {

               // ForEach(vm.gateways) { gateway in
                    GatewayRow(
                        gateway: GatewayLocal(id: "1", name: "VISA".localized, label: "VISA".localized, icon: "VisaIcon"),
                        isSelected: vm.selectedGateway.id == "1"
                    ) {
                        vm.selectedGateway = GatewayLocal(id: "1", name: "VISA", label: "VISA".localized, icon: "VisaIcon")
                        vm.selectedBrand = nil
                    }
                
                GatewayRow(
                    gateway: GatewayLocal(id: "2", name: "Wallet".localized, label: "Wallet".localized, icon: "walletIcon"),
                    isSelected: vm.selectedGateway.id == "2"
                ) {
                    vm.selectedGateway = GatewayLocal(id: "2", name: "Wallet".localized, label: "Wallet".localized, icon: "walletIcon")
                    vm.selectedBrand = nil
                }
                
                if vm.selectedGateway.id == "2" {
                    walletBalance
                }

                    // Show brands if needed
//                    if vm.selectedGateway?.id == gateway.id,
//                       gateway.requiresBrand {
//
//                        BrandListView(
//                            brands: gateway.brands,
//                            selectedBrand: vm.selectedBrand
//                        ) { brand in
//                            vm.selectedBrand = brand
//                        }
//                        .padding(.leading, 20)
//                    }
              //  }
            }
            .padding()
        }
    }
    
    private var paymnetButton: some View {
        
        Button("Continue".localized) {
            if vm.selectedGateway.id == "1" {
                vm.checkOut(paramter: .init(payment_method: "moyasar", brand: "visa"))
            }else {
                if (vm.balanceModel?.balance ?? 0.0) < (vm.orderPrice ?? 0.0) {
                    
                    showAlert = true
                }else {
                    vm.checkOutWallet()
                }
               
            }
            
        }
        .buttonStyle(.borderedProminent)
       // .disabled(!vm.canContinue)
    }
    
   private var walletBalance: some View {
        HStack {
           
            HStack {
                Image("Wallet-1")
                    .resizable()
                    .foregroundStyle(Color.MainColor)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 28)
                    .font(.system(size: 30))
                Text(vm.balanceModel?.formatted_balance ?? "")
                    .keyboardType(.numberPad)
                    .padding(13)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.CGray1)
                    )
                    .padding(.leading, 7)
                
               
            }
            
        }
    }
}
struct GatewayRow: View {

    let gateway: GatewayLocal
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {

                Image(gateway.icon ?? "")
                    .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(8)

                VStack(alignment: .leading, spacing: 4) {
                    Text(gateway.label).bold()
                   
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3)))
        }
    }
    
   
}
struct BrandListView: View {

    let brands: [BrandGateway]
    let selectedBrand: BrandGateway?
    let onSelect: (BrandGateway) -> Void

    var body: some View {
        VStack(spacing: 8) {

            ForEach(brands, id: \.id) { brand in
                Button {
                    onSelect(brand)
                } label: {
                    HStack {

                        AsyncImage(url: URL(string: brand.icon ?? "")) { img in
                            img.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.2)
                        }
                        .frame(width: 30, height: 30)

                        Text(brand.name ?? "")

                        Spacer()

                        if selectedBrand?.id == brand.id {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.gray.opacity(0.08))
                    )
                }
            }
        }
    }
}
