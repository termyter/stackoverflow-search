//
//  AnswerModel.swift
//  stackoverflow
//
//  Created by termyter on 20.07.2022.
//

import Foundation


struct AnswerModel: Codable, Hashable {
    var image: String
    var name: String
    var date: Date
    var body: String
    var score: Int

    static let empty = AnswerModel(image: "",name: "", date: Date(), body: "", score: 0)

}
