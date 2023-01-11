//
//  CheckAuthCode.swift
//  GreenHouseApp
//
//  Created by Вадим on 01.01.2023.
//

import Foundation

struct CheckAuthCode: Codable {
    let refreshToken, accessToken: String?
    let userID: Int?
    let isUserExists: Bool?

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case userID = "user_id"
        case isUserExists = "is_user_exists"
    }
}
