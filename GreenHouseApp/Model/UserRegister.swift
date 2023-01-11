//
//  UserRegister.swift
//  GreenHouseApp
//
//  Created by Вадим on 02.01.2023.
//

import Foundation

struct UserRegister: Codable {
    let refreshToken, accessToken: String

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
    }
}
