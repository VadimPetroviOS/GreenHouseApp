import Foundation

struct GetCurrentUser: Codable {
    let profileData: ProfileData

    enum CodingKeys: String, CodingKey {
        case profileData = "profile_data"
    }
}

struct ProfileData: Codable {
    let name, username: String
    let birthday, city, vk, instagram: String?
    let status, avatar: String?
    let id: Int
    let last: String?
    let online: Bool
    //let created: Date
    let phone: String
    let completedTask: Int
    let avatars: String?

    enum CodingKeys: String, CodingKey {
        case name, username, birthday, city, vk, instagram, status, avatar, id, last, online, phone
        case completedTask = "completed_task"
        case avatars
    }
}

