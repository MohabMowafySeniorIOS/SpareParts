//
//  AddressAgendaView.swift
//  MyAuctions
//
//  Created by Moaaz Ahmed on 20/07/2025.
//

import SwiftUI

struct AddressAgendaView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                NormalAppBar(title: "address_agenda") {
                    dismiss()
                }
                ScrollView(.vertical, showsIndicators: false){
                    LazyVStack(spacing:20) {
                        SimpleSpareButton(buttonTitle: "add_address", action: {
                            
                        }, widthValue: 300, heightValue: 50)
                        .padding(.top)
                        
                        TitleLabel(title: "added_addresses_menu")
                        
                        ForEach(0..<5) { _ in
                            VStack{
                                HStack(alignment:.top,spacing:30){
                                    VStack(alignment:.leading,spacing:10){
                                        HStack(spacing:90){
                                            Text("category")
                                                .foregroundStyle(.main)
                                        }
                                    }
                                    
                                    VStack(alignment:.leading,spacing:10){
                                        HStack(spacing:90){
                                            Text("qoiwebrtiquhwebcriuhqwbirechbqwiuerhbciuqhbcweirhbqiwcehbriuqhwbcepirh")
                                                .foregroundStyle(.main)
                                        }
                                    }
                                    Spacer()
                                }
                                HStack{
                                    SimpleSpareButton(buttonTitle: "edit", action: {
                                        
                                    }, widthValue: 160, heightValue: 30)
                                    
                                    SmallButtonWithBorder(action: {
                                        
                                    }, title: "delete")
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle()).fill(.main))
                            .padding(1)

                        }

                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    AddressAgendaView()
}
