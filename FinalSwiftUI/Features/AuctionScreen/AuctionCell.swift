//
//  AuctionCell.swift
//  FinalSwiftUI
//
//  Created by Mohab on 19/05/2025.
//


import SwiftUI

struct AuctionCell: View {
    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            
            // Heart icon on the left
            ZStack {
                HStack {
                    Spacer()
                    Image.FavouriteBtn
                      
                    
                }

                HStack {
                    Spacer()
                    Image.carImage // Replace with your asset name
                        
                        .scaledToFill()
                        .frame(height: 150)
                        .clipped()
                        .cornerRadius(10)
                    Spacer()
                }
            }
           
            // Car image
           

            // City & Title
            HStack {
                AuctionItem(Label: "das", Value: "dasd")
                Spacer()
                AuctionItem(Label: "das", Value: "dasd")
            }


            Divider()

            Group {
                AuctionItem(Label: "das", Value: "dasd")
                AuctionItem(Label: "das", Value: "dasd")
                AuctionItem(Label: "das", Value: "dasd")
                HStack {
                    AuctionItem(Label: "das", Value: "dasd")
                    Spacer()
                    AuctionItem(Label: "das", Value: "dasd")
                }
                HStack {
                    AuctionItem(Label: "das", Value: "dasd")
                    Spacer()
                    AuctionItem(Label: "das", Value: "dasd")
                }
                HStack {
                    AuctionItem(Label: "das", Value: "dasd")
                    Spacer()
                    AuctionItem(Label: "das", Value: "dasd")
                }
                HStack {
                    Spacer()
                    AuctionItem(Label: "das", Value: "dasd")
                    Spacer()
                 
                }
            } //.environment(\.layoutDirection, .rightToLeft) // RTL support

        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding()
        .environment(\.layoutDirection, .rightToLeft) // RTL support
       
    }
}

// Reusable row for label/value
struct InfoRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title).bold()
            Spacer()
            Text(value)
        }
    }
}

struct CarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AuctionCell()
    }
}
