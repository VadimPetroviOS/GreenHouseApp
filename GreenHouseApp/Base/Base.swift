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
        var phone: String
        var name: String?
        var username: String?
        var city: String?
        var birthday: String?
        var vk: String?
        var instagram: String?
        var status: String?
        var filename: Avatar
    }
    
    struct Avatar: Codable {
        var filename: String?
        var base64: String?
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
    
    var avatar : [Avatar] {
        get {
            if let data = defaults.value(forKey: "userData") as? Data {
                return try! PropertyListDecoder().decode([Avatar].self, from: data)
            } else {
                return [Avatar]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "userData")
            }
        }
    }
    
    func saveData(phone: String, name: String?,username: String?, city: String?, birthday: String?, vk: String?, instagram: String?, status: String?, filename: String?, base64: String?) {
        let avatar = Avatar(filename: filename, base64: base64)
        let data = UserData(phone: phone,
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
