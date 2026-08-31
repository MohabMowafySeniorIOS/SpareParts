//
//  AppStatusManager.swift
//  FinalSwiftUI
//
//  Watches a single Firestore document in real time and decides whether to
//  force a "maintenance" or "update required" screen on top of the whole app,
//  no matter which screen the user is currently standing on.
//
//  Firestore path: app_config/app_status
//  Fields:
//    - isMaintenance : Bool    -> true forces the maintenance screen
//    - latestVersion : String  -> compared against the app's own version;
//                                 if the installed version is older, the
//                                 update screen is forced automatically.
//

import Foundation
import FirebaseFirestore

/// The same status key used everywhere in the app to decide which blocking
/// screen (if any) should be shown.
enum App_updated_enum: String {
    case under_maintainance
    case updated
}

final class AppStatusManager: ObservableObject {
    static let shared = AppStatusManager()

    /// nil == everything is fine, no overlay is shown.
    @Published private(set) var status: App_updated_enum?

    private let collectionName = "appVersion"
    private let documentName = "appVersion"

    private var listener: ListenerRegistration?

    private init() {}

    /// Call once, right after FirebaseApp.configure().
    func startListening() {
        guard listener == nil else { return }

        listener = Firestore.firestore()
            .collection(collectionName)
            .document(documentName)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self else { return }

                if let error {
                    print("AppStatusManager: failed to listen for app status ->", error)
                    return
                }
print(snapshot)
                guard let data = snapshot?.data() else {
                    self.status = nil
                    return
                }
                
                print(data)

                self.evaluate(data: data)
            }
    }

    func stopListening() {
        listener?.remove()
        listener = nil
    }

    private func evaluate(data: [String: Any]) {
        let isMaintenance = data["iosneedMaintain"] as? Bool ?? false
        if isMaintenance {
            status = .under_maintainance
            return
        }

        if let latestVersion = data["iosversion"] as? String,
           isUpdateAvailable(currentVersion: appVersion ?? "0", latestVersion: latestVersion) {
            status = .updated
            return
        }

        status = nil
    }

    /// Same numeric version comparison approach used across the app's
    /// update-checking logic.
    private func isUpdateAvailable(currentVersion: String, latestVersion: String) -> Bool {
        currentVersion.compare(latestVersion, options: .numeric) == .orderedAscending
    }
}
