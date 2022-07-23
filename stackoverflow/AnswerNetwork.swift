//
//  AnswerNetwork.swift
//  stackoverflow
//
//  Created by termyter on 20.07.2022.
//

import Foundation
import UIKit

class AnswerNetwork {
    let session: URLSession
    var answerNetworkDelegate: AnswerhNetworkDelegate?

    func fetch(idPost: String) {
        var listModels: [AnswerModel] = []
        if let url = createURLComponents(idPost: idPost) {
            url.asyncDownload { data, _, error in
                guard let data = data else {
                    print("URLSession dataTask error:", error ?? "nil")
                    return
                }

                do {
                    let jsonObject = try JSONDecoder().decode(AnswerNetworkModel.self, from: data)
                    _ = String(data: data, encoding: .utf8)
                    for object in jsonObject.items {
                        let timeInterval = TimeInterval(object.creationDate)

                        let newDate = Date(timeIntervalSince1970: timeInterval)
                        let model = AnswerModel(
                            image: object.owner.profileImage,
                            name: String(htmlEncodedString: object.owner.displayName) ?? "",
                            date: newDate,
                            body: String(htmlEncodedString: object.body) ?? "",
                            score: object.score
                        )
                        listModels.append(model)
                    }
                    DispatchQueue.main.async {
                        self.answerNetworkDelegate?.getListModels(noteModels: listModels)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    init(
        session: URLSession = URLSession(configuration: .default)
    ) {
        self.session = session
    }

    private func createURLComponents(idPost: String) -> URL? {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "api.stackexchange.com"
        urlComponents.path = "/2.3/questions/" + idPost + "/answers"
        urlComponents.queryItems = [
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "sort", value: "activity"),
            URLQueryItem(name: "site", value: "stackoverflow"),
            URLQueryItem(name: "filter", value: "!6VvPDzQHbd2UL")
        ]
        return urlComponents.url!
    }

    private func createURLRequest(idPost: String) -> URLRequest {
        var request = URLRequest(url: createURLComponents(idPost: idPost)!)
        request.httpMethod = "GET"
        return request
    }
}

