import Foundation

struct GetCurrentUser: Codable {
    let profileData: ProfileData

    enum CodingKeys: String, CodingKey {
        case profileData = "profile_data"
    }
}

struct ProfileData: Codable {
    let name, username: String
    let birthday, city, vk, instagram: JSONNull?
    let status, avatar: JSONNull?
    let id: Int
    let last: JSONNull?
    let online: Bool
    let created: Date
    let phone: String
    let completedTask: Int
    let avatars: JSONNull?

    enum CodingKeys: String, CodingKey {
        case name, username, birthday, city, vk, instagram, status, avatar, id, last, online, created, phone
        case completedTask = "completed_task"
        case avatars
    }
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

