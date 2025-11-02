//
//  TeatVC.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 12/12/2024.
//

import Foundation
import SwiftUI
import AppleArchive

struct TestVC: View {
    
//    @State private  var Stringname = "mohab"
//    @State private var text: String = "This is a TextEditor."
      @State private var isPresented: Bool = true
//    @State private var scrollOffset: CGFloat = 1.0
//    @State private var OpacityView: Double = 1.0
//    @State private var userRating: Int = 3
    var body: some View {
//        HStack {
//            Spacer()
//            StarRatingView(rating: $userRating)
//            Spacer()
//        }
//      
//        Text("asdasdasdasdasdasdasdasdasdasdasdas")
//                   .font(.largeTitle)
//                   .foregroundColor(.clear)
//                  // .background(Color.red.opacity(scrollOffset))
//                   .frame(width: .infinity,height: 60)
//                   .background(Color.red.opacity(scrollOffset))
//                   
//        ScrollView {
//            
//           
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            
//            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/assets/icons/canceled.png")).frame(width: 100, height: 100)
//            ZStack {
//                LinearGradient(colors: [.blue , .white], startPoint: .leading, endPoint: .trailing).ignoresSafeArea(.all)
//                VStack {
//                    
//                    Text("Hello, World!")
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
//                        .padding()
//                        .padding()
//                        .onTapGesture {
//                            LoginVC(isPremium: true).sheet(isPresented: $isPresented) {
//                                
//                            }
//                        }
//                    
//                    
//                    
//                    Spacer()
//                }
//        }
//      
//            
//        }.onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
//            scrollOffset = value
//        }
//        
//        
        
        TabView {
                    // First Tab
                    Text("Home Screen")
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }

                    // Second Tab
         //   LoginVC()                    .tabItem {
//                            Label("Profile", systemImage: "person.fill")
//                        }

                    // Third Tab
                    Text("Settings Screen")
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                }

        VStack {
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            ColorPicker(/*@START_MENU_TOKEN@*/"Title"/*@END_MENU_TOKEN@*/, selection: /*@START_MENU_TOKEN@*/.constant(.red)/*@END_MENU_TOKEN@*/)

            DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })

            DisclosureGroup(/*@START_MENU_TOKEN@*/"Group"/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
            EditButton()
            Form {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
            Gauge(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/, in: /*@START_MENU_TOKEN@*/0...1/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/
            }
            Link(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=URL@*/URL(string: "https://www.apple.com")!/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*/Text("Link")/*@END_MENU_TOKEN@*/
            }
            Gauge(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/, in: /*@START_MENU_TOKEN@*/0...1/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/
            }
            List {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
            Form {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
            TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                Text("Tab Content 1").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 1")/*@END_MENU_TOKEN@*/ }.tag(1)
                Text("Tab Content 2").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 2")/*@END_MENU_TOKEN@*/ }.tag(2)
            }



            DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
//            Menu(/*@START_MENU_TOKEN@*/"Menu"/*@END_MENU_TOKEN@*/) {
//                /*@START_MENU_TOKEN@*/Text("Menu Item 1")/*@END_MENU_TOKEN@*/
//                /*@START_MENU_TOKEN@*/Text("Menu Item 2")/*@END_MENU_TOKEN@*/
//                /*@START_MENU_TOKEN@*/Text("Menu Item 3")/*@END_MENU_TOKEN@*/
//            }
//
//            MultiDatePicker(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/, selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Binding<Set<DateComponents>>@*/.constant([])/*@END_MENU_TOKEN@*/)
        }
        NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label Content@*/Text("Navigate")/*@END_MENU_TOKEN@*/
        }
        List(1..<40) {_ in
            Text("dasda;lsjdioajsoidjio")


        }.refreshable {
            print("Mohab resfresh liusrt")
        }
        
        VStack {
            AsyncImage(url: URL(string: "https://treat.sa/admin_v2/public/uploads/branches/g0BOZtklEIf8uhPE9dGbGqlho11qH2suZPTWCZ5I.jpg")).frame(width: 100, height: 100).clipped().clipShape(.circle)

            Button(action: {
                print("Hello, World!")
                isPresented.toggle()
            }) {
                Text("Hello example")

            }
        }

        .sheet(isPresented: $isPresented) {
            LoginVC()
            
                .presentationDetents([.medium,.large])
        }
        
        
    }
          
       
}

#Preview {
    TestVC()
}

