//
//  VendorsListView.swift
//  SpareParts
//
//  Created by Mohab on 07/02/2026.
//

import Foundation
import SwiftUI

struct VendorsListView: View {
    var vendors: [Trader]
    var orderNow: (Trader)->()
    var favouriteAction: (Trader)->()
    /// اختياري: بيتنادى لما كل كارت يظهر (للـ pagination)
    var onItemAppear: ((Trader)->())? = nil
    /// اختياري: يظهر loader تحت الليستة لو فيه صفحات تانية
    var showLoadMoreIndicator: Bool = false
    /// اختياري: pull to refresh
    var onRefresh: (()->())? = nil

    var body: some View {
        if let onRefresh = onRefresh {
            listContent
                .refreshable { onRefresh() }
        } else {
            listContent
        }
    }
    
    private var listContent: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(vendors, id: \.id) { vendor in
                    VendorGridCard(orderNow: {
                        orderNow(vendor)
                    }, vendorsModel: vendor, favouriteAction: {
                        favouriteAction(vendor)
                    })
                    .onAppear {
                        onItemAppear?(vendor)
                    }
                }
                
                if showLoadMoreIndicator {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
            }
            .padding()
        }
    }
}

