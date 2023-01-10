//
//  Base.swift
//  GreenHouseApp
//
//  Created by Вадим on 08.01.2023.
//

import Foundation

class Base {
    let defaults = UserDefaults.standard
    static let shared = Base()
    
    struct UserData: Codable {
        var accessToken: String!
        var refreshToken: String!
        var phone: String
        var name: String?
        var username: String?
        var city: String?
        var birthday: String?
        var vk: String?
        var instagram: String?
        var status: String?
        var avatar: String?
    }
    
    var userData : [UserData] {
        get {
            if let data = defaults.value(forKey: "userData") as? Data {
                return try! PropertyListDecoder().decode([UserData].self, from: data)
            } else {
                return [UserData]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "userData")
            }
        }
    }
    
    func saveData(accessToken: String, refreshToken: String, phone: String, name: String?,username: String?, city: String?, birthday: String?, vk: String?, instagram: String?, status: String?, avatar: String?) {
        print(accessToken)
        let data = UserData(accessToken: accessToken,
                            refreshToken: refreshToken,
                            phone: phone,
                            name: name,
                            username: username,
                            city: city,
                            birthday: birthday,
                            vk: vk,
                            instagram: instagram,
                            status: status,
                            avatar: avatar)
         
       userData.insert(data, at: 0)
    }
}
