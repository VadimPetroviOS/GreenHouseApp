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
                print(responce)
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
                print(error)
            }
        }
        task.resume()
    }
    
    func userRegister(number: String, name: String, userName: String, completion : @escaping (UserRegister?) -> ()) {
        var request = ApiType.userRegister.request
        
        let parameters : [String: AnyHashable] = [
            "phone": "\(number)",
            "name": "\(name)",
            "username": "\(userName)"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let responce = try JSONDecoder().decode(UserRegister.self, from: data)
                print("SUCCESS: \(responce)")
                //completion(responce)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func checkAuthCode() {
        guard let url = URL(string: "https://plannerok.ru/api/v1/users/check-auth-code/") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters : [String: AnyHashable] = [
            "phone": "+79219999999",
            "code": "133337"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                //let responce = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let responce = try JSONDecoder().decode(CheckAuthCode.self, from: data)
                print("SUCCESS: \(responce)")
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
