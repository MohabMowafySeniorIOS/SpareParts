import SwiftUI



import SwiftUI

enum FilterSection {
    case category, brand, model, manuYear, kilometres,color,carState,exOwners, license, engine, fuel, transmition, price
}

struct FilterGroup {
    let title: String
    let section: FilterSection
    
}

struct FilterCarStatesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var openSections: Set<FilterSection> = []
    @State private var selectedFilters: [FilterSection: Set<String>] = [:]
    
    @StateObject private var viewModel = FilterCarStatesViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    
    let filterGroups: [FilterGroup] = [
        .init(title: "category".localized, section: .category),
        .init(title: "brand".localized, section: .brand),
        .init(title: "model".localized, section: .model),
        .init(title: "manufacture year".localized, section: .manuYear),
        .init(title: "color".localized, section: .color),
        .init(title: "car state".localized, section: .carState),
        .init(title: "ex-owners count".localized, section: .exOwners),
        .init(title: "car license".localized, section: .license),
        .init(title: "engine size".localized, section: .engine),
        .init(title: "fuel type".localized, section: .fuel),
        .init(title: "transmition".localized, section: .transmition),
        .init(title: "price".localized, section: .price)
    ]
    
 

    var body: some View {
        AppHeaderView(Title:  "filter", action: {dismiss()})
            .padding(.bottom)

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
                viewModel.getBrands()
                viewModel.getCategories()
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
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(filterGroups, id: \.section) { group in
                    filterGroupSection(group)
                        .padding(.horizontal)
                    dividerView()
                }

                filterKilometresSection()
                    .padding(.horizontal)
                dividerView()

                filterActionButtons()
                    .padding(.horizontal)
            }
        }.navigationBarBackButtonHidden()
    }
    

    @ViewBuilder
    func filterGroupSection(_ group: FilterGroup) -> some View {
        filterSection(title: group.title, section: group.section)
    }

    @ViewBuilder
    func filterSection(title: String, section: FilterSection) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title.capitalized)
                    .foregroundStyle(.cBlack)
                Spacer()
                Image(systemName: "chevron.up")
                    .rotationEffect(.degrees(openSections.contains(section) ? 180 : 0))
                    .foregroundStyle(.main)
                    .font(.system(size: 25))
                    
            }
            .background()
            .onTapGesture {
                toggleSection(section)
            }

            if openSections.contains(section) {
                VStack(alignment: .leading, spacing: 8) {
                    if section == .category {
                        ForEach(viewModel.categoryModel, id: \.self) { item in
                            FilterBoxes(filterText: item.name ?? "",
                                        isSelected: selectedFilters[section]?.contains(item.name ?? "") ?? false) {
                                toggleFilter(section: section, filter: item.name ?? "")
                            }
                        }
                    }else if section == .brand {
                        ForEach(viewModel.brandModel, id: \.self) { item in
                            FilterBoxes(filterText: item.name ?? "",
                                        isSelected: selectedFilters[section]?.contains(item.name ?? "") ?? false) {
                                toggleFilter(section: section, filter: item.name ?? "")
                            }
                        }
                    }

                }
                .padding(.vertical, 4)
            }
        }
    }

    @ViewBuilder
    func filterKilometresSection() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("kilometres".localized.capitalized)
                    .foregroundStyle(.cBlack)
                Spacer()
                Image(systemName: "chevron.up")
                    .rotationEffect(.degrees(openSections.contains(.kilometres) ? 180 : 0))
                    .foregroundStyle(.main)
                    .font(.system(size: 25))
                    .onTapGesture {
                        toggleSection(.kilometres)
                    }
            }
            .padding(.vertical, 8)

            if openSections.contains(.kilometres) {
                HStack(spacing: 16) {
                    HStack {
                        Text("from".localized)
                        TextField("", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 80)
                    }
                    HStack {
                        Text("to".localized)
                        TextField("", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 80)
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }

    func dividerView() -> some View {
        Rectangle()
            .fill(.main)
            .frame(height: 1)
            .padding(.vertical)
    }

    @ViewBuilder
    func filterActionButtons() -> some View {
        HStack {
            ContentButtonView(title: "save".localized) {
                
            }
            Spacer()
            CustomeButtonWithBorderColor(title: "reset".localized) {
                
            }
        }
    }

    private func toggleSection(_ section: FilterSection) {
        if openSections.contains(section) {
            openSections.remove(section)
        } else {
            openSections.insert(section)
        }
    }
    
    private func toggleFilter(section: FilterSection, filter: String) {
        var filters = selectedFilters[section] ?? Set<String>()
        if filters.contains(filter) {
            filters.remove(filter)
        } else {
            filters.insert(filter)
        }
        selectedFilters[section] = filters
    }
    
    
}

#Preview {
    FilterCarStatesView()
}

struct FilterBoxes: View {
    
    var filterText: String
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 0)
                .stroke(style: StrokeStyle())
                .fill(.cGray1)
                .frame(width: 20, height: 20)
                .overlay(
                    Group {
                        if isSelected {
                            Image(systemName: "checkmark")
                                .foregroundColor(.main)
                                .font(.system(size: 14, weight: .bold))
                        }
                    }
                )
            Text(filterText)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}
