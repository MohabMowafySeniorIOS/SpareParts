//
//  VendorHomeView.swift
//  SpareParts
//
//  Created by Mohab on 13/02/2026.
//

import Foundation
import SwiftUI

struct HomeVendor: View {
    
    @State private var isReceivingOrders = true
    @ObservedObject private var viewModel: VendorHomeViewModel
    
    init(viewModel: VendorHomeViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        containView
            .background(
                Color(Color.backGroundColor)
            )
    }
    
    private var containView: some View {
        VStack {
            topParView
            ShowViewState(state: viewModel.state) { Model in
                scrollView
            }
            Spacer()
        }
    }
    
    private var scrollView: some View {
        ScrollView {
            VStack(spacing: 24) {
                toggleSection
                statisticsSection
                ordersSection
                buttonSection
            }
            .padding()
        }
       
    }
    
    private var topParView: some View {
        HomeTopBar(
            userName: AuthService.userData?.full_name ?? "",
            notificationAction: {
                
            }
        )
    }
    
    // MARK: Toggle Section
    private var toggleSection: some View {
        HStack {
           
            Text("home.receive_orders".localized)
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
            
            Toggle("", isOn: $isReceivingOrders)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: Color.SecondaryColor))
        }
    }
    
    // MARK: Statistics
    @ViewBuilder
    private var statisticsSection: some View {
        HStack {
            Text("home.statistics".localized)
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
        }
       
        
        VStack(spacing: 14) {
            StatRow(title: "home.sent_offers_count".localized, value: "15 عرض")
            StatRow(title: "home.sent_offers_total".localized, value: "1500 ريال")
            StatRow(title: "home.orders_count".localized, value: "15 طلب")
            StatRow(title: "home.orders_total".localized, value: "1500 ريال")
            StatRow(title: "home.completed_orders".localized, value: "15 طلب")
            StatRow(title: "home.cancelled_orders".localized, value: "15 طلب")
        }
    }
    
    // MARK: Orders
    @ViewBuilder
    private var ordersSection: some View {
        HStack {
            Text("home.last_orders".localized)
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
        }
        
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                OrderCard()
                OrderCard()
            }
            .padding(.horizontal, 2)
        }
    }
    
    // MARK: Button
    private var buttonSection: some View {
        Button {
            
        } label: {
            Text("home.show_all".localized)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.MainColor)
                .cornerRadius(30)
        }
        .padding(.top, 10)
    }
}

#Preview {
    HomeVendor(viewModel: VendorHomeViewModel(coordinator: MainCoordinator(appCoordinator: AppCoordinator())))
}


// MARK: Stat Row
struct StatRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
           
            Text(LocalizedStringKey(title))
                .foregroundColor(.SecondaryColor)
            Spacer()
            Text(value)
                .font(.body)
            
        }
    }
}


// MARK: Order Card
struct OrderCard: View {
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
            
            CardRow(title: "order.id".localized, value: "15552")
            CardRow(title: "order.type".localized, value: "شاسية")
            CardRow(title: "order.pieces".localized, value: "4")
            CardRow(title: "order.city".localized, value: "الرياض")
            CardRow(title: "order.date".localized, value: "15/2/2025")
            CardRow(title: "order.time".localized, value: "7:15 ص")
        }
        .padding()
        .frame(width: 240)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}


// MARK: Card Row
struct CardRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .foregroundColor(.SecondaryColor)
            
            Spacer()
            Text(value)
        }
    }
}
