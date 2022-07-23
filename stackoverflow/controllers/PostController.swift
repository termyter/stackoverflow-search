//
//  PostController.swift
//  stackoverflow
//
//  Created by termyter on 19.07.2022.
//

import Foundation
import UIKit

protocol AnswerhNetworkDelegate: AnyObject {
    func getListModels(noteModels: [AnswerModel])
}

class PostController: UIViewController, UITableViewDelegate, UITableViewDataSource, AnswerhNetworkDelegate{
    func getListModels(noteModels: [AnswerModel]) {
        listModels += noteModels
        table.reloadData()
    }
    
    private var listModels: [AnswerModel] = []
    private var searchText = UITextField()
    private var searchButton = UIButton()
    private var table = UITableView()
    private let answerNetwork = AnswerNetwork()
    var model: PostModel = PostModel.empty 



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        table.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        table.register(CustomAnswerCell.self, forCellReuseIdentifier: "CustomAnswerCell")
        table.delegate = self
        table.dataSource = self


        setupUI()
        answerNetwork.answerNetworkDelegate = self

        //переделать
        answerNetwork.fetch(idPost: model.id)
    }


    private func setupUI() {
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        view.addSubview(table)

        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listModels.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
                fatalError("не CustomCell")
            }
            cell.cellView.image.userInteractionEnabled =
            let lpgr = UITapGestureRecognizer(target: self, action: #selector(PostController.handleTapPress(_:)))
            cell.cellView.image.addGestureRecognizer(lpgr)
            
            cell.selectionStyle = .none
            cell.model = model
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomAnswerCell", for: indexPath) as? CustomAnswerCell else {
                fatalError("не CustomCell")
            }
            cell.selectionStyle = .none
            cell.model = listModels[indexPath.row - 1]
            return cell
        }
    }

    @objc func handleTapPress(_ gesture: UITapGestureRecognizer){
        UIApplication.shared.openURL(URL(string: model.link)!)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}

extension String {

    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }

}
