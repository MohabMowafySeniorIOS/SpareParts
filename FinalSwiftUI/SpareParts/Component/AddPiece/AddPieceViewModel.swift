//
//  AddPieceViewModel.swift
//  SpareParts
//
//  Created by Mohab on 14/02/2026.
//

import Foundation
import Combine
import SwiftUI

class AddPieceViewModel: ObservableObject {
    
    @Published var state: viewState<HomeResponse?> = .idle
    @Published var isFavourit: Bool?
    @Published var pickedImages: [AttachMentModel?] = []
    
    // Every AddPiece screen gets its own upload session.
    // This prevents an old upload callback from adding its image
    // to a newly opened piece.
    private(set) var uploadSessionID = UUID()
    
    @discardableResult
    func startNewUploadSession() -> UUID {
        uploadSessionID = UUID()
        pickedImages = []
        return uploadSessionID
    }
    
    func completeProfile(parameters: BaseParameters) {
        let url = "\(hostName)\(EndPoints.completeProfile.rawValue)"
        state = .loading(loading: .progress)
        APIClient.shared.performRequestWithAlamofire(urlString: url, method: .post, parameters: parameters.toDictionary()) { [weak self] (Model: BaseModel<HomeResponse>?, err: String?) in
            guard let self = self else { return }
            if Model?.status == "success" {
                self.state = .loaded(data: Model?.data)
            } else {
                self.state = .error(err ?? "")
            }
        }
    }
    
    // MARK: - Upload
    
    func attachMents(
        urlEndPoint: EndPoints = .storeAttachMents,
        file: UIImage?,
        methodType: HTTPMethodType = .post,
        parameters: BaseParameters,
        sessionID: UUID
    ) async {
        let url = "\(hostName)\(urlEndPoint.rawValue)"
        
        await withCheckedContinuation { continuation in
            APIClient.shared.uploadMultipartWithAlamofire(
                urlString: url,
                file: file,
                parameters: parameters.toDictionary()
            ) { [weak self] (Model: BaseModel<AttachMentModel>?, err: String?) in
                DispatchQueue.main.async {
                    guard let self = self else {
                        continuation.resume()
                        return
                    }
                    
                    // Ignore callbacks belonging to a previous AddPiece screen.
                    guard self.uploadSessionID == sessionID else {
                        continuation.resume()
                        return
                    }
                    
                    if Model?.status == "success", let attachment = Model?.data {
                        self.pickedImages.append(attachment)
                        self.state = .loaded(data: self.state.data)
                    } else {
                        self.state = .error(err ?? "")
                    }
                    
                    continuation.resume()
                }
            }
        }
    }
}
