import SwiftUI

enum AdType{
    case regular,auction
}

struct stateBoxContent: Identifiable{
    var id = UUID()
    var isBoxSelected: Bool
    var boxName: String
}


struct MenuFilterSheetView: View {
    
    let rows: [GridItem] = [
        GridItem(.fixed(30)), // spacing between rows
        GridItem(.fixed(30))
    ]
    
    @State var stateBoxLabels: [stateBoxContent] = [
        stateBoxContent(isBoxSelected: false, boxName: "in_progress"),
        stateBoxContent(isBoxSelected: false, boxName: "rejected"),
        stateBoxContent(isBoxSelected: false, boxName: "deleted"),
        stateBoxContent(isBoxSelected: false, boxName: "active"),
        stateBoxContent(isBoxSelected: false, boxName: "expired")
    ]

    
    @State var isPresented: Bool = false
    @State var isAdTypeExpanded: Bool = false
    @State var isAdStateExpanded: Bool = false
    @State var isBoxSelected: Bool = false
    @State var adType: AdType = .regular
    @Binding var biggerSheet: Bool
    @Binding var biggerSheettwo: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            ZStack {
                Text("menu_filter".localized)
                    .font(addFont(fontType: .Medium, size: 20))

                HStack {
                    Image(systemName: "xmark")
                        .font(.system(size: 30))
                        .onTapGesture {
                            biggerSheet = false
                            biggerSheettwo = false
                            dismiss()
                        }
                    Spacer()
                }
            }
            .padding(.bottom)
        VStack (spacing: 20){
            VStack{
                HStack{
                    Text("ad_type")
                        .font(addFont(fontType: .Regular, size: 20))
                    
                    Spacer()
                    
                    Image(.arrowDown)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.main)
                        .frame(width: 30,height: 30)
                        .scaleEffect(x: isAdTypeExpanded ? 1 : -1, y: isAdTypeExpanded ? 1 : -1)
                }
                .background()
                .onTapGesture {
                    isAdTypeExpanded.toggle()
                    biggerSheet.toggle()
                }
                
                if isAdTypeExpanded{
                    HStack{
                        VStack{
                            FilterAdTypeSheetBarItem(box: adType == .regular ? Image(.checkedIcon) : Image(.unCheckedIcon), boxColor: adType == .regular ? .main : .CGray3, barName: "regular")
                                .onTapGesture {
                                    adType = .regular
                                }
                            
                            FilterAdTypeSheetBarItem(box: adType == .auction ? Image(.checkedIcon) : Image(.unCheckedIcon), boxColor: adType == .auction ? .main : .CGray3, barName: "auction")
                                .onTapGesture {
                                    adType = .auction
                                }
                            
                        }
                        Spacer()
                    }
                }
            }
            
            VStack{
                HStack{
                    Text("ad_state")
                        .font(addFont(fontType: .Regular, size: 20))
                    
                    Spacer()
                    
                    Image(.arrowDown)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.main)
                        .frame(width: 30,height: 30)
                        .scaleEffect(x: isAdStateExpanded ? 1 : -1, y: isAdStateExpanded ? 1 : -1)
                }
                .background()
                .onTapGesture {
                    isAdStateExpanded.toggle()
                    biggerSheettwo.toggle()
                }
                
                HStack{
                    if isAdStateExpanded{
                        LazyHGrid(rows: rows,spacing: 20) {
                            ForEach($stateBoxLabels) { $item in
                                HStack{
                                    FilterAdStateSheetBarItem(isBoxSelected: item.isBoxSelected, barName: item.boxName)
                                        .onTapGesture {
                                            item.isBoxSelected.toggle()
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                }
            }
           
            
        }
        .padding(.horizontal)
        .ignoresSafeArea()
        
        HStack{
            ContentButtonView(title: "save") {
                
            }
            Spacer()
            CustomeButtonWithBorderColor(title: "reset") {
                
            }
        }
        .padding(.top)

        }
        .padding(.horizontal)
        .ignoresSafeArea()

    }
}

#Preview {
    MenuFilterSheetView(biggerSheet: .constant(false), biggerSheettwo: .constant(false))
}

struct FilterAdTypeSheetBarItem: View {
    
    
    var box: Image
    var boxColor: Color
    var barName: String
    
    var body: some View {
        HStack{
            box
                .renderingMode(.template)
                .foregroundStyle(boxColor)
            
            Text(barName.localized)
                .font(addFont(fontType: .Regular, size: 16))
        }
    }
}

struct FilterAdStateSheetBarItem: View {
    
    var isBoxSelected: Bool
    var barName: String
    
    var body: some View {
        HStack{
            if isBoxSelected{
                Image(.checkedIcon)
                .renderingMode(.template)
                .foregroundStyle(.main)
            }else{
                Image(.unCheckedIcon)
                .renderingMode(.template)
                .foregroundStyle(.cGray3)
            }
            
            Text(barName.localized)
                .font(addFont(fontType: .Regular, size: 16))
        }
        .frame(maxHeight: 24)
    }
}










//
//HStack{
//    VStack{
//        FilterAdStateSheetBarItem(adState: $adState, box: adState == .inProgress ? Image(.checkedIcon) : Image(.unCheckedIcon), boxColor: adState == .inProgress ? .main : .CGray3, barName: "in_progress")
//            .onTapGesture {
//                adState = .inProgress
//            }
//        FilterAdStateSheetBarItem(adState: $adState, box: adState == .deleted ? Image(.checkedIcon) : Image(.unCheckedIcon), boxColor: adState == .deleted ? .main : .CGray3, barName: "deleted")
//            .onTapGesture {
//                adState = .deleted
//            }
//    
//    }
//    VStack{
//        FilterAdStateSheetBarItem(adState: $adState, box: adState == .inProgress ? Image(.checkedIcon) : Image(.unCheckedIcon), boxColor: adState == .inProgress ? .main : .CGray3, barName: "in_progress")
//            .onTapGesture {
//                adState = .inProgress
//            }
//        FilterAdStateSheetBarItem(adState: $adState, box: adState == .deleted ? Image(.checkedIcon) : Image(.unCheckedIcon), boxColor: adState == .deleted ? .main : .CGray3, barName: "deleted")
//            .onTapGesture {
//                adState = .deleted
//            }
//    
//    }
//    VStack{
//        FilterAdStateSheetBarItem(adState: $adState, box: adState == .inProgress ? Image(.checkedIcon) : Image(.unCheckedIcon), boxColor: adState == .inProgress ? .main : .CGray3, barName: "in_progress")
//            .onTapGesture {
//                adState = .inProgress
//            }
//    }
//}
//
//
//Button {
//    isPresented = false
//} label: {
//    Text("other sections".capitalized)
//        .foregroundStyle(.cBlack)
//        .padding(.vertical, 10)
//        .frame(maxWidth: .infinity)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .fill(.cGray3.opacity(0.7))
//        )
//}
