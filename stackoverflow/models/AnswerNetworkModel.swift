// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let answerNetworkModel = try? newJSONDecoder().decode(AnswerNetworkModel.self, from: jsonData)

import Foundation

// MARK: - AnswerNetworkModel
class AnswerNetworkModel: Codable {
    let items: [ItemA]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }

    init(items: [ItemA], hasMore: Bool, quotaMax: Int, quotaRemaining: Int) {
        self.items = items
        self.hasMore = hasMore
        self.quotaMax = quotaMax
        self.quotaRemaining = quotaRemaining
    }
}

// MARK: - Item
class ItemA: Codable {
    let owner: OwnerA
    let isAccepted: Bool
    let score, lastActivityDate, creationDate, answerID: Int
    let questionID: Int
    let contentLicense, title, body: String

    enum CodingKeys: String, CodingKey {
        case owner
        case isAccepted = "is_accepted"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case answerID = "answer_id"
        case questionID = "question_id"
        case contentLicense = "content_license"
        case title, body
    }

    init(owner: OwnerA, isAccepted: Bool, score: Int, lastActivityDate: Int, creationDate: Int, answerID: Int, questionID: Int, contentLicense: String, title: String, body: String) {
        self.owner = owner
        self.isAccepted = isAccepted
        self.score = score
        self.lastActivityDate = lastActivityDate
        self.creationDate = creationDate
        self.answerID = answerID
        self.questionID = questionID
        self.contentLicense = contentLicense
        self.title = title
        self.body = body
    }
}

// MARK: - Owner
class OwnerA: Codable {
    let accountID, reputation, userID: Int
    let userType: String
    let profileImage: String
    let displayName: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case reputation
        case userID = "user_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
    }

    init(accountID: Int, reputation: Int, userID: Int, userType: String, profileImage: String, displayName: String, link: String) {
        self.accountID = accountID
        self.reputation = reputation
        self.userID = userID
        self.userType = userType
        self.profileImage = profileImage
        self.displayName = displayName
        self.link = link
    }
}
