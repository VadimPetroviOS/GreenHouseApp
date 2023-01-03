//
//  UserRegister.swift
//  GreenHouseApp
//
//  Created by Вадим on 02.01.2023.
//

import Foundation

struct UserRegister: Codable {
    let refreshToken, accessToken: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case userID = "user_id"
    }
}
