//
//  ApiManager.swift
//  GreenHouseApp
//
//  Created by Вадим on 29.12.2022.
//

import Foundation

enum ApiType {
    
    case sendAuthCode
    case checkAuthCode
    case userRegister
    case getCurrentUser
    case updateUser
    case refreshToken
    case checkJWT
    
    var baseURL: String {
        return "https://plannerok.ru/"
    }
    
    var headers: [String:String] {
        switch self {
        case .checkAuthCode:
            return ["phone": "String"]
        case .getCurrentUser:
            return ["Authorization": "String"]
        default:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .sendAuthCode: return "api/v1/users/send-auth-code/"
        case .checkAuthCode: return "api/v1/users/check-auth-code/"
        case .userRegister: return "api/v1/users/register/"
        case .getCurrentUser, .updateUser: return "api/v1/users/me/"
        case .refreshToken: return "api/v1/users/refresh-token/"
        case .checkJWT: return "api/v1/users/check-jwt/"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        switch self {
        case .sendAuthCode:
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        case .checkAuthCode:
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        case .userRegister:
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        case .getCurrentUser:
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "accept")
            return request
        case .updateUser:
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        default:
            request.httpMethod = "GET"
            return request
        }
    }
}

class ApiManager {
    static let shared = ApiManager()
    
    func sendAuthCode(number: String, completion : @escaping (SendAuthCode?) -> ()) {
        var request = ApiType.sendAuthCode.request
        let parameters = ["phone": number]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { (data, responce, error) in
            if let responce = responce {
                //print(responce)
            }
            guard let data = data else { return }
            do {
                let sendAuthCode = try? JSONDecoder().decode(SendAuthCode.self, from: data)
                completion(sendAuthCode)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func checkAuthCode(number: String, authCode: String, completion : @escaping (CheckAuthCode?) -> ()) {
        var request = ApiType.checkAuthCode.request
        
        let parameters : [String: AnyHashable] = [
            "phone": "\(number)",
            "code": "\(authCode)"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let responce = try JSONDecoder().decode(CheckAuthCode.self, from: data)
                //print("SUCCESS: \(responce)")
                completion(responce)
            }
            catch {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func userRegister(number: String, name: String, username: String, completion : @escaping (UserRegister?) -> ()) {
        var request = ApiType.userRegister.request
        
        let parameters : [String: AnyHashable] = [
            "phone": "\(number)",
            "name": "\(name)",
            "username": "\(username)"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let responce = try JSONDecoder().decode(UserRegister.self, from: data)
                //print("SUCCESS: \(responce)")
                completion(responce)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getCurrentUser(accessToken: String, completion : @escaping (GetCurrentUser?) -> ()) {
        var request = ApiType.getCurrentUser.request
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, responce, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let responce = try JSONDecoder().decode(GetCurrentUser.self, from: data)
                //print("SUCCESS: \(responce)")
                completion(responce)
            }
            catch {
                print("FAILURE: \(error)")
                completion(nil)
                
            }
        }
        task.resume()
    }
    
    func updateUser(uploadDataModel: UpdateUser, completion : @escaping (UpdateUser?) -> ()) {
        var request = ApiType.updateUser.request
        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjMwOCwidXNlcm5hbWUiOiJCdXNpZG9DYWQiLCJwaG9uZSI6IjkxNzEyMzQ1NjciLCJpYXQiOjE2NzMyOTU2MTgsImV4cCI6MTY3MzI5NjIxOH0.tX7AtJTGIY5Hs3W5vgPuc4oZwXYpdg2Y0yUakxHVCxw"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                    print("Error: Trying to convert model to JSON data")
                    return
        }
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling PUT")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                let httpResponse = response as! HTTPURLResponse
                print(httpResponse.statusCode)
                return
            }
            
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                                
                print(prettyPrintedJson)
            }
            catch {
                print("FAILURE: \(error)")
            }
        }
        task.resume()
    }
}

/*
 let avatar : [String: AnyHashable] = [
     "filename": "\(uploadDataModel.avatar!.filename)",
     "base64": "\(uploadDataModel.avatar!.base64)",
 ]
 let parameters : [String: AnyHashable] = [
     "name": "\(uploadDataModel.name)",
     "username": "\(uploadDataModel.username)",
     "birthday": "\(uploadDataModel.birthday)",
     "city": "\(uploadDataModel.city)",
     "vk": "\(uploadDataModel.vk)",
     "instagram": "\(uploadDataModel.instagram)",
     "status": "\(uploadDataModel.status)",
     "avatar": avatar
 ]
 print(avatar)
 print(parameters)
 guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed) else { return }
 request.httpBody = httpBody
 */
