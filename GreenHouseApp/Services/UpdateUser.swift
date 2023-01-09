//
//  UpdateUser.swift
//  GreenHouseApp
//
//  Created by Вадим on 08.01.2023.
//

import Foundation

struct UpdateUser: Codable {
    let name, username, birthday, city: String
    let vk, instagram, status: String
    let avatar: Avatar?
}

struct Avatar: Codable {
    let filename, base64: String

    enum CodingKeys: String, CodingKey {
        case filename
        case base64 = "base_64"
    }
}
