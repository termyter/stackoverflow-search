//
//  WorkerClass.swift
//  stackoverflow
//
//  Created by termyter on 15.07.2022.
//

import Foundation

class SearchNetwork {
    let session: URLSession
    var searchNetworkDelegate: SearchNetworkDelegate?

    func fetch(question: String) {
        var listModels: [PostModel] = []
        if let url = createURLComponents(question: question) {
            url.asyncDownload { data, _, error in
                guard let data = data else {
                    print("URLSession dataTask error:", error ?? "nil")
                    return
                }

                do {
                    let jsonObject = try JSONDecoder().decode(SearchNetworkModel.self, from: data)
                    _ = String(data: data, encoding: .utf8)
                    for object in jsonObject.items {
                        let timeInterval = TimeInterval(object.creationDate)

                        let newDate = Date(timeIntervalSince1970: timeInterval)
                        let model = PostModel(
                            id: String(object.questionID),
                            title: String(htmlEncodedString: object.title) ?? "",
                            image: object.owner.profileImage!,
                            name: String(htmlEncodedString: object.owner.displayName) ?? "",
                            date: newDate,
                            answer_count: Int32(object.answerCount),
                            body: String(htmlEncodedString: object.body) ?? "",
                            link: object.owner.link ?? ""
                        )
                        listModels.append(model)
                    }
                    DispatchQueue.main.async {
                        self.searchNetworkDelegate?.getListModels(postModels: listModels)
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

    private func createURLComponents(question: String) -> URL? {
        var urlComponents = URLComponents()

        urlComponents.scheme = "https"
        urlComponents.host = "api.stackexchange.com"
        urlComponents.path = "/2.3/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "sort", value: "activity"),
            URLQueryItem(name: "intitle", value: question),
            URLQueryItem(name: "site", value: "stackoverflow"),
            URLQueryItem(name: "filter", value: "!nKzQUR3Egv")
        ]
        return urlComponents.url!
    }

    private func createURLRequest(question: String) -> URLRequest {
        var request = URLRequest(url: createURLComponents(question: question)!)
        request.httpMethod = "GET"
        return request
    }
}

extension URL {
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}
