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
            let httpResponse = responce as! HTTPURLResponse
            print(httpResponse.statusCode)
            
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
}
// 0101a4ab-d39f-4d4b-873c-5f20388bf207

/* if request.setValue(accessToken, forHTTPHeaderField: "Authorization")
 FAILURE: dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.", underlyingError: Optional(Error Domain=NSCocoaErrorDomain Code=3840 "Invalid value around line 1, column 0." UserInfo={NSDebugDescription=Invalid value around line 1, column 0., NSJSONSerializationErrorIndex=0})))
 */

/* request.setValue("pipi", forHTTPHeaderField: "Authorization")
 FAILURE: dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.", underlyingError: Optional(Error Domain=NSCocoaErrorDomain Code=3840 "Invalid value around line 1, column 0." UserInfo={NSDebugDescription=Invalid value around line 1, column 0., NSJSONSerializationErrorIndex=0})))

 */

/* request.setValue("Bearer access token", forHTTPHeaderField: "Authorization")
 FAILURE: keyNotFound(CodingKeys(stringValue: "profile_data", intValue: nil), Swift.DecodingError.Context(codingPath: [], debugDescription: "No value associated with key CodingKeys(stringValue: \"profile_data\", intValue: nil) (\"profile_data\").", underlyingError: nil))
 */

/*
 FAILURE: typeMismatch(Swift.Double, Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "profile_data", intValue: nil), CodingKeys(stringValue: "created", intValue: nil)], debugDescription: "Expected to decode Double but found a string/data instead.", underlyingError: nil))

 */

/* let responce = try JSONDecoder().decode(SendAuthCode.self, from: data)
 FAILURE: keyNotFound(CodingKeys(stringValue: "is_success", intValue: nil), Swift.DecodingError.Context(codingPath: [], debugDescription: "No value associated with key CodingKeys(stringValue: \"is_success\", intValue: nil) (\"is_success\").", underlyingError: nil))
 */
