//
//  PostCell.swift
//  stackoverflow
//
//  Created by termyter on 20.07.2022.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {

    private var cellView = PostView()
    private var selectedButton = UIButton(type: .custom)
    var model: PostModel? {
        get {
            cellView.model
        }
        set {
            cellView.model = newValue ?? PostModel.empty
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isHidden = false
        isSelected = false
        isHighlighted = false

        self.model = PostModel.empty
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellView)

        cellView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
}
