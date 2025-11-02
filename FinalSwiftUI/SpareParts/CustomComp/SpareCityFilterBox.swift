//
//  SpareCityFilterBox.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 15/07/2025.
//

import SwiftUI

struct SpareCityFilterBox: View {
    
    var isBoxActive: Bool
    var city: String
    
    var body: some View {
        HStack{
            if !isBoxActive{
                Image(.unCheckedIcon)
            }else{
                Image(.checkedIcon)
                    .renderingMode(.template)
                    .foregroundStyle(.main)
            }
                Text(city)
                    .foregroundStyle(isBoxActive ? .cBlack : .cGray1)
            }
        }
    }


#Preview {
    SpareCityFilterBox(isBoxActive: false, city: "masr")
}
