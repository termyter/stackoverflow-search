//
//  ViewController.swift
//  stackoverflow
//
//  Created by termyter on 15.07.2022.
//

import UIKit

protocol SearchNetworkDelegate: AnyObject {
    func getListModels(postModels: [PostModel])
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchNetworkDelegate{
    private var listModels: [PostModel] = []
    private var searchText = UITextField()
    private var searchButton = UIButton()
    private var table = UITableView()
    private let searchNetwork = SearchNetwork()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchNetwork.searchNetworkDelegate = self
        setupSearchText()
        setupSearchButton()
        table.register(CustomPostCell.self, forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = self

        setupUI()
    }

    func getListModels(postModels: [PostModel]) {
        listModels = postModels
        table.reloadData()
    }

    private func setupSearchText() {
        searchText.translatesAutoresizingMaskIntoConstraints = false
        searchText.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        searchText.textColor = .black
        searchText.backgroundColor = .white
        searchText.borderStyle = UITextField.BorderStyle.roundedRect
        searchText.layer.borderWidth = 1
        searchText.layer.borderColor = UIColor.black.cgColor
        view.addSubview(searchText)
        searchText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchText.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20
        ).isActive = true
        searchText.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70
        ).isActive = true
    }

    private func setupSearchButton() {
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.backgroundColor = .white
        searchButton.layer.borderWidth = 1
        searchButton.setTitle("OK", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)

        searchButton.layer.borderColor = UIColor.black.cgColor
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(didSearchButtonnTap(_:)), for: .touchUpInside)
        searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchButton.leadingAnchor.constraint(
            equalTo: searchText.safeAreaLayoutGuide.trailingAnchor, constant: 10
        ).isActive = true
        searchButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20
        ).isActive = true
    }
    private func setupUI() {
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        view.addSubview(table)

        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.topAnchor.constraint(equalTo: searchText.bottomAnchor,constant: 20).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomPostCell else {
            fatalError("не CustomCell")
        }
        cell.selectionStyle = .none
        cell.model = listModels[indexPath.row]
        cell.layer.cornerRadius = 14
        cell.layer.shadowRadius = 14

        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = PostController()
        post.model = listModels[indexPath.row]
        self.navigationController?.pushViewController(post, animated: true)
    }

    @objc private func didSearchButtonnTap(_ sender: Any) {
        view.endEditing(true)
        searchNetwork.fetch(question: searchText.text ?? "")
        table.reloadData()
    }
}

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIImageView {

    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image.imageResized(to: CGSize(width: 65.0, height: 65.0))
                    }
                }
            }
        }
    }
}

