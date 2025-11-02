//
//  SidMEnueView.swift
//  MyAuctions
//
//  Created by Moaaz on 15/06/2025.
//


//
//  SidMEnueView.swift
//  FinalSwiftUI
//
//  Created by Mohab on 17/05/2025.
//

import SwiftUI

struct SidMEnueView: View {
    @State var title : String
    let textColor: Color
    var body: some View {
        Text(title)
             .frame(maxWidth: .infinity, alignment: .leading)
             .font(addFont(fontType: .Regular, size: 16))
             .foregroundColor(textColor)
    }
}

#Preview {
    SidMEnueView(title: "Home", textColor: .main)
}
