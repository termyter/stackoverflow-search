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

protocol PostCellDelegate: AnyObject {
    func klickImage(sender: UITapGestureRecognizer)
}



class PostController: UIViewController, UITableViewDelegate, UITableViewDataSource, AnswerhNetworkDelegate, PostCellDelegate{
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
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44.0
        
        table.estimatedRowHeight = 68.0
        table.rowHeight = UITableView.automaticDimension
        
        
        setupUI()
        answerNetwork.answerNetworkDelegate = self
        
        
        answerNetwork.fetch(idPost: model.id)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        table.reloadData()
        
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
            cell.postCellDelegate = self
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
    
    
    func klickImage(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            guard let url = URL(string: model.link) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func getListModels(noteModels: [AnswerModel]) {
        listModels += noteModels
        table.reloadData()
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
