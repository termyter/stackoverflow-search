// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchNetworkModel = try? newJSONDecoder().decode(SearchNetworkModel.self, from: jsonData)

import Foundation

// MARK: - SearchNetworkModel
class SearchNetworkModel: Codable {
    let items: [Item]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int
    
    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
    
    init(items: [Item], hasMore: Bool, quotaMax: Int, quotaRemaining: Int) {
        self.items = items
        self.hasMore = hasMore
        self.quotaMax = quotaMax
        self.quotaRemaining = quotaRemaining
    }
}

// MARK: - Item
class Item: Codable {
    let tags: [String]
    let owner: Owner
    let isAnswered: Bool
    let viewCount, answerCount, score, lastActivityDate: Int
    let creationDate: Int
    let lastEditDate: Int?
    let questionID: Int
    let contentLicense: ContentLicense?
    let link: String
    let title, body: String
    let acceptedAnswerID, closedDate: Int?
    let closedReason: String?
    
    enum CodingKeys: String, CodingKey {
        case tags, owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case lastEditDate = "last_edit_date"
        case questionID = "question_id"
        case contentLicense = "content_license"
        case link, title, body
        case acceptedAnswerID = "accepted_answer_id"
        case closedDate = "closed_date"
        case closedReason = "closed_reason"
    }
    
    init(tags: [String], owner: Owner, isAnswered: Bool, viewCount: Int, answerCount: Int, score: Int, lastActivityDate: Int, creationDate: Int, lastEditDate: Int?, questionID: Int, contentLicense: ContentLicense?, link: String, title: String, body: String, acceptedAnswerID: Int?, closedDate: Int?, closedReason: String?) {
        self.tags = tags
        self.owner = owner
        self.isAnswered = isAnswered
        self.viewCount = viewCount
        self.answerCount = answerCount
        self.score = score
        self.lastActivityDate = lastActivityDate
        self.creationDate = creationDate
        self.lastEditDate = lastEditDate
        self.questionID = questionID
        self.contentLicense = contentLicense
        self.link = link
        self.title = title
        self.body = body
        self.acceptedAnswerID = acceptedAnswerID
        self.closedDate = closedDate
        self.closedReason = closedReason
    }
}

enum ContentLicense: String, Codable {
    case ccBySa25 = "CC BY-SA 2.5"
    case ccBySa30 = "CC BY-SA 3.0"
    case ccBySa40 = "CC BY-SA 4.0"
}

// MARK: - Owner
class Owner: Codable {
    let accountID, reputation, userID: Int
    let userType: UserType
    let acceptRate: Int?
    let profileImage: String
    let displayName: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case reputation
        case userID = "user_id"
        case userType = "user_type"
        case acceptRate = "accept_rate"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
    }
    
    init(accountID: Int, reputation: Int, userID: Int, userType: UserType, acceptRate: Int?, profileImage: String, displayName: String, link: String) {
        self.accountID = accountID
        self.reputation = reputation
        self.userID = userID
        self.userType = userType
        self.acceptRate = acceptRate
        self.profileImage = profileImage
        self.displayName = displayName
        self.link = link
    }
}

enum UserType: String, Codable {
    case registered = "registered"
    case unregistered = "unregistered"
}
