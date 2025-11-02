import PhotosUI
import SwiftUI
//REMAKE FROM SCRATCH CAUSE TRASHHHHHHHHHHHH

struct AddAdMainView: View {

    @StateObject private var viewModel = AddAdMainViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true

    @State private var bars: [BarModel] = [
        BarModel(
            title: "city".localized,
            boxes: []),
        BarModel(
            title: "category".localized,
            boxes: []),
        BarModel(title: "brand".localized, boxes: []),
        BarModel(
            title: "papers_state".localized,
            boxes: []),
        BarModel(
            title: "color".localized,
            boxes: []),
    ]

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navi: AppState

    @State var selection: Int = 0
    @State var auctionName: String = ""
    @State var carDescription: String = ""
    @State var isCheckBox: Bool = false
    @State var fieldState = FieldsTextBinds()
    @State var ismyAds: Bool = false
    @State var isHome: Bool = false
    @State var naviToHome: Bool = false
    @State var navo: Bool = false

    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State var pickedImages: [UIImage] = []

    @State private var startDate = Date()
    @State private var EndDate = Date()

    @State var isShowDatePicker: Bool = false
    @State var isShowEndDatePicker: Bool = false

    var body: some View {
        NavigationStack {

            ZStack {
                errorToast
                if viewModel.isLoading == true {
                    LoaderView(rotation: $rotation, isLoading: $isLoading)
                        .frame(width: 100, height: 100)
                } else {
                    mainContent
                }
            }
            .onAppear {
                viewModel.getCategories()
                viewModel.getBrands()
                viewModel.getCities()
            }
            .onReceive(viewModel.$cityModel) { Model in
                bars[0].boxes = Model

            }
            .onReceive(viewModel.$categoryModel) { Model in
                bars[1].boxes = Model

            }
            .onReceive(viewModel.$brandModel) { Model in
                bars[2].boxes = Model

            }

        }
    }

    @ViewBuilder
    private var errorToast: some View {
        if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
            ToastView(message: errorMessage, backgroundColor: .cRed)
                .transition(.move(edge: .top))
                .zIndex(0.1)
        }
    }

    // MARK: - Main Content

    private var mainContent: some View {
        NavigationStack {
            AppHeaderView(
                Title: "add_ad", action: { dismiss() })
            ScrollView {
                ZStack {
                    VStack {
                        HStack {
                            HStack {
                                AddPhotoButton(
                                    showImagePicker: $showImagePicker,
                                    selectedImage: selectedImage)
                                ScrollView(.horizontal, showsIndicators: false)
                                {
                                    HStack(spacing: 10) {
                                        ForEach(
                                            pickedImages.indices, id: \.self
                                        ) { item in
                                            Image(uiImage: pickedImages[item])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 130, height: 130)
                                                .clipped()
                                                .cornerRadius(8)
                                        }
                                    }
                                }
                                .frame(height: 150)
                            }
                            .padding(.leading)
                        }
                        VStack(spacing: 20) {
                            AddAdTextField(
                                fieldText: $fieldState.auctionName,
                                barName: "auction_name".localized)
                            //city

                            AddAdIconBar(bar: $bars[0])

                            ZStack(alignment: .topLeading) {
                                CustomTextEditor(text: $carDescription)
                                    .frame(height: 150)

                                if carDescription.isEmpty {
                                    Text("car_description".localized)
                                        .foregroundColor(.cBlack)
                                        .padding(.leading, 14)
                                        .padding(.top, 12)
                                }
                            }

                            HStack {
                                Text("start_date".localized)
                                    .font(addFont(fontType: .Regular, size: 20))
                                Spacer()
                                Text(
                                    DateFormatter.dayMonthYear.string(
                                        from: startDate))
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.cGray3)
                            )
                            .onTapGesture {
                                isShowDatePicker.toggle()
                            }

                            if isShowDatePicker {
                                DatePicker(
                                    "", selection: $startDate,
                                    displayedComponents: .date
                                )
                                .datePickerStyle(.wheel)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.cGray3)
                                )
                            }

                            HStack {
                                Text("end_date".localized)
                                    .font(addFont(fontType: .Regular, size: 20))
                                Spacer()
                                Text(
                                    DateFormatter.dayMonthYear.string(
                                        from: EndDate))
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.cGray3)
                            )
                            .onTapGesture {
                                isShowEndDatePicker.toggle()
                            }

                            if isShowEndDatePicker {
                                DatePicker(
                                    "", selection: $EndDate,
                                    displayedComponents: .date
                                )
                                .datePickerStyle(.wheel)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.cGray3)
                                )
                            }

                            AddAdTextField(
                                fieldText: $fieldState.carState,
                                barName: "car_state".localized)
                            //Category
                            AddAdIconBar(bar: $bars[1])
                            //Brand
                            AddAdIconBar(bar: $bars[2])

                            AddAdTextField(
                                fieldText: $fieldState.carModel,
                                barName: "model".localized)

                            AddAdTextField(
                                fieldText: $fieldState.carModel,
                                barName: "manufacture_year".localized)

                            AddAdTextField(
                                fieldText: $fieldState.accidents,
                                barName: "accidents".localized)

                            AddAdTextField(
                                fieldText: $fieldState.exOwners,
                                barName: "ex_owners".localized)

                            AddAdTextField(
                                fieldText: $fieldState.licenseState,
                                barName: "license_state".localized)
                            //papers
                            AddAdIconBar(bar: $bars[3])

                            AddAdTextField(
                                fieldText: $fieldState.delayYears,
                                barName: "delay_years".localized)

                            AddAdTextField(
                                fieldText: $fieldState.kilometres,
                                barName: "kilometres".localized)
                            //color
                            AddAdIconBar(bar: $bars[4])

                            AddAdTextField(
                                fieldText: $fieldState.engineSize,
                                barName: "engine_size".localized)

                            AddAdTextField(
                                fieldText: $fieldState.fuelType,
                                barName: "fuel_type".localized)

                            AddAdTextField(
                                fieldText: $fieldState.transmition,
                                barName: "transmission".localized)

                            AddAdTextField(
                                fieldText: $fieldState.startingPrice,
                                barName: "starting_price".localized)

                            HStack {
                                if !isCheckBox {
                                    Image(.unCheckedIcon)
                                        .padding(.trailing)
                                } else {
                                    Image(.checkedIcon)
                                        .renderingMode(.template)
                                        .padding(.trailing)
                                        .foregroundStyle(.main)
                                }
                                Text("accept_terms_and_conditions".localized)
                                    .font(addFont(fontType: .Medium, size: 17))
                                Spacer()
                            }
                            .padding(.vertical)
                            .onTapGesture {
                                isCheckBox.toggle()
                            }

                            HStack {
                                ContentButtonView(title: "cancel".localized) {
                                    dismiss()
                                }

                                Spacer()

                                CustomeButtonWithBorderColor(
                                    title: "add".localized,
                                    action: {
                                        var x : Bool = true
                                        if !isCheckBox{
                                            x = false
                                        }
                                        if startDate >= EndDate{
                                            x = false
                                        }
                                        
                                        viewModel.createAuction(
                                            images: pickedImages,
                                            additional_images: pickedImages,
                                            parameters:
                                                .init(
                                                    city_id: "1",
                                                    agree_terms: "true",
                                                    title: fieldState
                                                        .auctionName,
                                                    description:
                                                        "fieldState.carDescibtion",
                                                    category_id: "1",
                                                    brand_id: "1",
                                                    model_id: "1",
                                                    year: "2023",
                                                    start_time:
                                                        "2025-08-05 22:00:00",
                                                    end_time:
                                                        "2025-08-05 22:00:00",
                                                    condition: "condition",
                                                    accidents_count: "0",
                                                    previous_owners: "0",
                                                    papers_status: "ready",
                                                    delay_years: "0",
                                                    mileage: "0",
                                                    color: "أبيض لؤلؤي",
                                                    engine_size: "2.5",
                                                    fuel_type: "gasoline",
                                                    transmission: "automatic",
                                                    starting_price: "9000",
                                                    reserve_price: "1000",
                                                    car_condition: "new"
                                                )
                                        )
                                        if x {
                                            ismyAds = true
                                        }
                                    }
                                )
                                .sheet(isPresented: $ismyAds) {
                                    ConfirmationAfterAdView()
                                        .presentationDetents([.height(400)])
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(onImagesPicked: { images in
                pickedImages.append(contentsOf: images)
            })
        }
        .navigationBarBackButtonHidden()

    }

}

#Preview {
    AddAdMainView()
}

struct AddPhotoButton: View {
    @Binding var showImagePicker: Bool
    var selectedImage: UIImage?

    var body: some View {
        VStack {
            Image(systemName: "plus")
                .foregroundStyle(.main)
                .font(addFont(fontType: .Regular, size: 40))
                .padding(.horizontal)
                .padding(.top)

            Text("add_photo".localized)
                .font(addFont(fontType: .Regular, size: 18))
                .foregroundStyle(.main)
                .padding()
                .padding(.bottom, 10)
        }
        .frame(width: 130, height: 130)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.cGray3)
        )
        .onTapGesture {
            showImagePicker = true
        }
    }
}

struct AddAdTextField: View {

    @Binding var fieldText: String
    let barName: String

    var body: some View {
        HStack {
            Text(barName.capitalized)
                .foregroundStyle(.cBlack)
            TextField("", text: $fieldText)
                .multilineTextAlignment(.leading)
        }
        .padding(10)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.cGray3)
        )
    }
}

struct AddAdIconBar: View {
    @Binding var bar: BarModel

    var body: some View {
        VStack {
            HStack {
                Text(bar.title.capitalized)
                    .foregroundStyle(.cBlack)
                Spacer()
                Image(systemName: "chevron.up")
                    .foregroundStyle(.main)
                    .font(.system(size: 25))
                    .rotationEffect(.degrees(bar.isExpanded ? 180 : 0))

            }
            .padding(10)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.cGray3)
            )

            VStack(spacing: 5) {
                if bar.isExpanded {
                    ForEach(bar.boxes.indices, id: \.self) { index in
                        var box = bar.boxes[index]
                        BarBox(
                            id: box.id ?? 0,
                            text: box.name ?? "",
                            isActive: box.is_selected,
                            onSelect: {
                                print(!bar.boxes[index].is_selected)
                                if bar.boxes[index].is_selected == false {
                                    bar.boxes = bar.boxes.map { item in
                                        var newItem = item
                                        newItem.is_selected = false
                                        return newItem
                                    }
                                    bar.boxes[index].is_selected = !bar.boxes[
                                        index
                                    ].is_selected
                                } else {
                                    bar.boxes[index].is_selected = false
                                }

                            }
                        )
                    }
                }
            }
        }
        .onTapGesture {
            bar.isExpanded.toggle()
        }
    }
}

struct BarBox: View {
    let id: Int
    let text: String
    var isActive: Bool
    let onSelect: () -> Void

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(isActive ? Color.main : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.main, lineWidth: 1)
                )
                .frame(width: 20, height: 20)
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .opacity(isActive ? 1 : 0))

            Spacer()
            Text(text)
        }
        .padding(10)
        .background(.cGray3)
        .cornerRadius(5)
        .onTapGesture {
            onSelect()
        }
    }
}
