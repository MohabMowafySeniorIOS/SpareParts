//
//  NetWorkWithAlamofire.swift
//  FinalSwiftUI
//
//  Created by Mohab Elsayed on 12/01/2025.
//

import Foundation
import Alamofire
var counter = 1
struct APIClient {
    static let shared = APIClient()
    private init() {}
    func performRequestWithAlamofire<T: Decodable>(
        urlString: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        
        completion: @escaping (T? ,String?)->Void) {
            var headers : HTTPHeaders?
            let lang = Language.english.rawValue
            headers = [
                "Accept-Language": lang,
                "Content-Type": "application/json",
                "Accept": "application/json",
            ]
            
            if AuthService.userData?.token != "" && AuthService.userData?.token  != nil {
                headers?["Authorization"] = "Bearer \(AuthService.userData?.token ?? "")"
            }
            print("HEADERS-------->\(headers)")
            print("parameters-------->\(parameters)")
            print("method-------->\(method)")
            print("urlString-------->\(urlString)")
          
            AF.request(
                urlString,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default, // Use `URLEncoding.default` for GET queries
                headers: headers
            )
            .responseData { response in
                switch response.result {
                case .success(let data):
                    
                    print(data)
                    guard let data = response.data else {
                        return
                    }
                    print(data)
                    do {
                        
                        
                        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                           let jsonDict = jsonObject as? [String: Any] {
                            print("Dictionary response: \(jsonDict)")
                            if ((jsonDict["status"] as? Int) == 0) || ((jsonDict["status"] as? Bool) == false){
                                completion(nil , jsonDict["message"] as? String)
                            }
                        } else {
                            print("Response is not a dictionary")
                        }
                        let Posts = try JSONDecoder().decode(T.self, from: data)
                        print(Posts)
                        completion(Posts, nil)
                    }catch let error {
                        completion(nil , "\(error)")
                        print("----------->>>>>>>>>>>>>>>" ,error , "----------->>>>>>>>>>>>>>>>>>")
                        
                    }
                    
                case .failure(let error):
                    print("----------->>>>>>>>>>>>>>>" ,error.localizedDescription , "----------->>>>>>>>>>>>>>>>>>")
                    completion(nil, handleAlamofireError(response: response, error: error))
                }
            }
        }
    
    func uploadMultipartWithAlamofire<T: Decodable>(
        urlString: String,
        images: UIImage = UIImage(),
        imageFieldName: String = "images[]", // Use "file" if it's a single image field
        additional_images: [UIImage] = [],
        additional_imageFieldName: String = "additional_images[]", // Use "file" if it's a single image field
        profile_image : UIImage? = nil,
        
        parameters: [String: Any] = [:],
        completion: @escaping (T?, String?) -> Void
    ) {
        let lang = Language.english.rawValue
        var headers: HTTPHeaders = [
            "Accept-Language": lang,
            "Accept": "application/json"
        ]
        
        if let token = AuthService.userData?.token, !token.isEmpty {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        print("HEADERS-------->\(headers)")
        print("parameters-------->\(parameters)")
       
        print("urlString-------->\(urlString)")

        AF.upload(
            multipartFormData: { multipartFormData in
                // Append images
                print(images)
            
//                if let imageData = UIImage(named: "image")?.jpegData(compressionQuality: 0.8) {
//                        
//                        multipartFormData.append(imageData, withName: "images[]", fileName: "images.jpg", mimeType: "images/jpeg")
//                    }
               
                for (index, image) in additional_images.enumerated() {
                    if let imageData = image.jpegData(compressionQuality: 0.8) {
                        let name = additional_imageFieldName.contains("[]") ? imageFieldName : "\(imageFieldName)[\(index)]"
                        multipartFormData.append(imageData, withName: name, fileName: "image\(index).jpg", mimeType: "image/jpeg")
                    }
                }
                
                if let imageData = profile_image?.jpegData(compressionQuality: 0.8) {
                    let name = "profile_image"
                    multipartFormData.append(imageData, withName: name, fileName: "image.jpg", mimeType: "image/jpeg")
                }

                // Append other form parameters
                for (key, value) in parameters {
                    let stringValue = "\(value)"
                    if let data = stringValue.data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            },
            to: urlString,
            method: .post,
            headers: headers
        )
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                   
                    if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                       let jsonDict = jsonObject as? [String: Any],
                       ((jsonDict["status"] as? Int) == 0 || (jsonDict["status"] as? Bool) == false) {
                        print(jsonDict)
                        completion(nil, jsonDict["message"] as? String)
                        return
                    }
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                   print(decoded)
                    completion(decoded, nil)
                } catch {
                    completion(nil, "\(error)")
                    print("Decoding error: \(error)")
                }
            case .failure(let error):
                print("Upload failed: \(error.localizedDescription)")
                completion(nil, handleAlamofireError(response: response, error: error))
            }
        }
    }

    
    
    func handleAlamofireError(response: AFDataResponse<Data>, error: AFError) -> String {
        var err = ""
        if let responseCode = response.response?.statusCode {
            print("HTTP Status Code: \(responseCode)")
            err = "User Not Authenticated"
            if let responseCode = response.response?.statusCode, responseCode == 401 {
                // restart app to login screen
            }
        }
        
        if let underlyingError = error.underlyingError {
            print("Underlying Error: \(underlyingError.localizedDescription)")
        }
        NoNetView(title: "Something went wrong! 🔧".localized, image: "Clip path group", Btn_Title: "Back To Home".localized)
        switch error {
        case .sessionTaskFailed(let sessionError):
            err = "Session Task Failed: \(sessionError.localizedDescription)"
            print("Session Task Failed: \(sessionError.localizedDescription)")
        case .responseValidationFailed(let reason):
            err = "Validation Error: \(reason)"
            print("Validation Error: \(reason)")
        case .responseSerializationFailed(let reason):
            print("Serialization Error: \(reason)")
            err = "Serialization Error: \(reason)"
        default:
            
            print("Other Error: \(error.localizedDescription)")
            err = "Other Error: \(error.localizedDescription)"
        }
        print("----------->>>>>>>>>>>>>>>" ,err , "----------->>>>>>>>>>>>>>>>>>")
        return err
    }
}
