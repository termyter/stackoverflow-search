//
//  cellModel.swift
//  stackoverflow
//
//  Created by termyter on 15.07.2022.
//

import Foundation

struct PostModel: Codable, Hashable {
    var id: String
    var title: String
    var image: String
    var name: String
    var date: Date
    var answer_count: Int32
    var body: String

    static let empty = PostModel(id: "", title: "", image: "",name: "", date: Date(), answer_count: 0, body: "")

}
