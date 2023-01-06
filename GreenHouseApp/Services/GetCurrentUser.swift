//
//  GetCurrentUser.swift
//  GreenHouseApp
//
//  Created by Вадим on 06.01.2023.
//

import Foundation

struct GetCurrentUser: Codable {
    let profileData: ProfileData

    enum CodingKeys: String, CodingKey {
        case profileData = "profile_data"
    }
}

struct ProfileData: Codable {
    let name, username, birthday, city: String
    let vk, instagram, status, avatar: String
    let id: Int
    let last: String
    let online: Bool
    let created, phone: String
    let completedTask: Int
    let avatars: Avatars

    enum CodingKeys: String, CodingKey {
        case name, username, birthday, city, vk, instagram, status, avatar, id, last, online, created, phone
        case completedTask = "completed_task"
        case avatars
    }
}

struct Avatars: Codable {
    let avatar, bigAvatar, miniAvatar: String
}
