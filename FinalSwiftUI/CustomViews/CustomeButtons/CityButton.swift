//
//  CityButton.swift
//  MyAuctions
//
//  Created by Moaaz on 06/07/2025.
//
import SwiftUI

struct GenericDropdownButton<T: Hashable>: View {
    
    let title: String
    @Binding var selectedItem: T
    let items: [T]
    let displayText: (T) -> String
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(title.localized)
                    .font(.custom(AppFont.Medium.rawValue, size: 16))
                Spacer()
            }
            HStack {
                Text(displayText(selectedItem))
                    .font(.custom(AppFont.Medium.rawValue, size: 16))
                    .foregroundStyle(Color.cBlack)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isExpanded ? 0 : 180))
            }
            .frame(height: 48)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle())
                    .foregroundStyle(isExpanded ? Color.main : Color.TextBorderColor)
            }
        }
    }
}

// Generic dropdown button with built-in sheet
struct GenericDropdownSheet<T: Hashable & Identifiable>: View {
    @Binding var selectedItem: T
    @Binding var isPresented: Bool
    let items: [T]
    let displayText: (T) -> String
//    let detentHeight: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(items) { item in
                HStack {
                    Text(displayText(item))
                        .padding(.horizontal)
                    Spacer()
                }
                .padding(.top, 10)
                .onTapGesture {
                    selectedItem = item
                    isPresented = false
                }
            }
        }
        .padding(.vertical, 20)
        .presentationDetents([.height(CGFloat(items.count * 50))])
    }
}

// Generic dropdown button with built-in sheet
struct GenericDropdown<T: Hashable & Identifiable>: View {
    let title: String
    @Binding var selectedItem: T
    let items: [T]
    let displayText: (T) -> String
//    let detentHeight: CGFloat
    
    @State private var isSheetPresented = false
    
    var body: some View {
        GenericDropdownButton(
            title: title,
            selectedItem: $selectedItem,
            items: items,
            displayText: displayText,
            isExpanded: $isSheetPresented
        )
        .onTapGesture {
            isSheetPresented = true
        }
        .sheet(isPresented: $isSheetPresented) {
            GenericDropdownSheet(
                selectedItem: $selectedItem,
                isPresented: $isSheetPresented,
                items: items,
                displayText: displayText
//                detentHeight: detentHeight
            )
        }
    }
}
