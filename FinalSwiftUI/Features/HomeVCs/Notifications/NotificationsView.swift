import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = NotificationsViewModel()
    @State private var rotation: Double = 0
    @State private var isLoading = true
    
    var body: some View {
        AppHeaderView(Title: "notifications") {
            dismiss()
        }
        VStack {
            if viewModel.isLoading {
                LoaderView(rotation: $rotation, isLoading: $isLoading)
                    .frame(width: 100, height: 100)
            } else {
                ScrollView {
                    VStack {
                        
                        ContentButtonView(title: "read_all_notifications".localized) {
                            viewModel.markAllAsRead()
                        }
                        .padding(.horizontal)

                        
                        ForEach(viewModel.notifications) { notification in
                            NotificationCard(notification: notification)
                        }
                    }
                }
            }
            
            Spacer()
            
            if let errorMessage = viewModel.errorMessage {
                ToastView(message: errorMessage, backgroundColor: .red)
                    .transition(.move(edge: .top))
                    .zIndex(1)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.fetchNotifications()
        }
    }
}

struct NotificationCard: View {
    let notification: Notification
    
    var body: some View {
        HStack {
            VStack {
                Text(notification.time)
                Text(notification.date)
            }
            Spacer()
            Text(notification.message)
        }
        .padding()
        .background(notification.isRead ? .cGray4 : .cGray3)
    }
}

#Preview {
    NotificationsView()
}
