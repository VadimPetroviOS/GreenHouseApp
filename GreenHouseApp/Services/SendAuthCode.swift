//
//  SendAuthCode.swift
//  GreenHouseApp
//
//  Created by Вадим on 30.12.2022.
//

import Foundation

struct SendAuthCode: Codable {
    let isSuccess: Bool

    enum CodingKeys: String, CodingKey {
        case isSuccess = "is_success"
    }
}

