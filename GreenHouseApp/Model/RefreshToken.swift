//
//  RefreshToken.swift
//  GreenHouseApp
//
//  Created by Вадим on 10.01.2023.
//

import Foundation

struct RefreshToken: Codable {
    let refreshToken, accessToken: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case userID = "user_id"
    }
}
