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

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(vendors, id: \.id) { vendor in
                    VendorGridCard(orderNow: {
                        orderNow(vendor)
                    }, vendorsModel: vendor, favouriteAction: {
                        favouriteAction(vendor)
                    })
                }
            }
            .padding()
        }
    }
}

