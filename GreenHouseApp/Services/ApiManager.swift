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
            request.setValue("application/json", forHTTPHeaderField: "accept")
            return request
        case .refreshToken:
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")
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
                //print("SUCCESS: \(responce)")
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
                print("FAILURE: \(error)")
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
                print("SUCCESS: \(responce)")
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
                print("SUCCESS: \(responce)")
                completion(responce)
            }
            catch {
                print("FAILURE: \(error)")
                completion(nil)
                
            }
        }
        task.resume()
    }

    func updateUser() {
        var request = ApiType.updateUser.request
        request.setValue("Bearer \(Base.shared.userData[0].accessToken!)", forHTTPHeaderField: "Authorization")
        let parameters : [String: AnyHashable] = [
            "name": "\(Base.shared.userData[0].name!)",
            "username": "\(Base.shared.userData[0].username!)",
            "birthday": "\(Base.shared.userData[0].birthday!)",
            "city": "\(Base.shared.userData[0].city!)",
            "vk": "\(Base.shared.userData[0].vk!)",
            "instagram": "\(Base.shared.userData[0].instagram!)",
            "status": "string",
            "avatar": ["filename": "string", "base_64": "string"]
        ]
        guard let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else { return }
        URLSession.shared.uploadTask(with: request, from: data) { (responseData, response, error) in
            if let error = error {
                print("Error making PUT request: \(error)")
                return
            }
            
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                /*
                guard responseCode == 200 else {
                    print("Invalid response code: \(responseCode)")
                    return
                }
                
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    print("Response JSON data = \(responseJSONData)")
                }
                */
            }
        }.resume()
    }
    
    func refreshToken(refreshToken: String, completion : @escaping (RefreshToken?) -> ()) {
        var request = ApiType.refreshToken.request
        let parameters = ["refresh_token": refreshToken]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                //print("SUCCESS: \(response)")
            }
            guard let data = data else { return }
            do {
                let refreshToken = try? JSONDecoder().decode(RefreshToken.self, from: data)
                
                completion(refreshToken)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
