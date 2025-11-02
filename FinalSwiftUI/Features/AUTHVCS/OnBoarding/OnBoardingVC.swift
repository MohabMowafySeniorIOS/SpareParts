//
//  OnBoardingVC.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 04/12/2024.
//

import SwiftUI
struct OnBoardingVC: View {
    @State private var currentPage = 0
    let totalPages = 3
    @State  var title1 = """
هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق
"""
    @State  var image1 = AssetImage.onboarding1_1
    @State  var image2 = AssetImage.onboarding2_1
    @State  var image3 = AssetImage.onboarding3_1
    
    @State private var title2 = "كل ماتحتاجة في مكان واحد"
    @State private var des2 = "سواء كنت تاجر أو عميل، فاينل توفر لك جميع الأدوات لإدارة متجرك أو طلب معداتك بكل سهولة و يُسر"
    
    @State private var title3 = "حول جوالك لمتجر كامل"
    @State private var des3 = "تحكم في كافة تفاصيل متجرك عبر التطبيق. أضف منتجات، تابع الطلبات، وشاهد إحصائياتك بسهولة تامه"
    
    
    @State var is_first_page = false
    @State var is_second_page = false
    @State var is_third_page = false
    
    var body: some View {
        VStack(spacing:0) {
            TabView(selection: $currentPage) {
                ForEach(0..<totalPages, id: \.self) { index in
                    VStack {
                        HStack {
                            Spacer()
                            SkipButton(title: "Skip".localized) {
                                print("Next")
                            }
                        }.padding()
                   
                        if index == 0 {
                         
                            CustomeOnBoardingView(title_label: $title1, image_title: $image1, is_first_page: $is_first_page)
                                
                              
                        }else if  index == 1 {
                            CustomeOnBoardingView(title_label: $title2, image_title: $image2, is_first_page: $is_second_page)
                        }else if  index == 2 {
                            CustomeOnBoardingView(title_label: $title3, image_title: $image3, is_first_page: $is_third_page)
                        }
                        Spacer()
                    }
                    
                   
                    
                }
            }
           
        } .edgesIgnoringSafeArea(.all)
       .tabViewStyle(PageTabViewStyle())
    
        .edgesIgnoringSafeArea(.all)
    }
}
#Preview{
    OnBoardingVC()
}
//import SwiftUI
//
//struct CustomPageControlView: View {
//    @State private var currentPage = 0
//    let totalPages = 5
//
//    var body: some View {
//        VStack {
//            // TabView for pages
//            TabView(selection: $currentPage) {
//                ForEach(0..<totalPages, id: \.self) { index in
//                    Color(hue: Double(index) / Double(totalPages), saturation: 0.8, brightness: 0.8)
//                        .ignoresSafeArea()
//                        .tag(index)
//                }
//            }
//            .tabViewStyle(PageTabViewStyle())
//           // .indexViewStyle(.never) // Disable default dots
//            
//            // Custom Page Control
//            HStack(spacing: 10) {
//                ForEach(0..<totalPages, id: \.self) { index in
//                    Capsule()
//                        .frame(width: index == currentPage ? 30 : 10, height: 10) // Active page is longer
//                        .foregroundColor(index == currentPage ? .blue : .gray)
//                        .animation(.easeInOut(duration: 0.2), value: currentPage)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct CustomPageControlView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomPageControlView()
//    }
//}
//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        Path { path in
//            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//            path.closeSubpath()
//        }
//    }
//}
//
//struct PageView: View {
//    @State private var currentPage = 0
//    let pages = [
//        Page(title: "Welcome", color: .CBrown),
//        Page(title: "Discover", color: .CBrown),
//        Page(title: "Enjoy", color: .CBrown)
//    ]
//    
//    var body: some View {
//        VStack {
//            TabView(selection: $currentPage) {
//                ForEach(0..<pages.count, id: \.self) { index in
//                    CustomPageView(page: pages[index])
//                        .tag(index) // Tag for selection
//                }
//            }
//            .tabViewStyle(PageTabViewStyle())
//            .indexViewStyle(PageIndexViewStyle())
//            
//            // Navigation Buttons
//            HStack {
//                Button("Previous") {
//                    if currentPage > 0 {
//                        currentPage -= 1
//                    }
//                }
//                .disabled(currentPage == 0)
//                
//                Button("Next") {
//                    if currentPage < pages.count - 1 {
//                        currentPage += 1
//                    }
//                }
//                .disabled(currentPage == pages.count - 1)
//            }
//            .padding()
//        }
//    }
//}
//
////struct PageView_Previews: PreviewProvider {
////    static var previews: some View {
////        PageView()
////    }
////}
//struct Page: Identifiable {
//    let id = UUID()
//    let title: String
//    let color: Color
//}
//
//struct CustomPageView: View {
//    let page: Page
//    
//    var body: some View {
//        page.color
//            .ignoresSafeArea()
//            .overlay(
//                Text(page.title)
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//            )
//    }
//}
