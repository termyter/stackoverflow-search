//
//  CustomAnswerCell.swift
//  stackoverflow
//
//  Created by termyter on 18.07.2022.
//

import Foundation
import UIKit


class CustomAnswerCell: UITableViewCell {

    private var cellView = AnswerView()
    private var selectedButton = UIButton(type: .custom)
    var model: AnswerModel? {
        get {
            cellView.model
        }
        set {
            cellView.model = newValue ?? AnswerModel.empty
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupView()
        layer.cornerRadius = 14
        layer.shadowRadius = 14
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isHidden = false
        isSelected = false
        isHighlighted = false

        self.model = AnswerModel.empty
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellView)

        cellView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        cellView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: 16
        ).isActive = true
        cellView.trailingAnchor.constraint(
            equalTo: trailingAnchor, constant: -16
        ).isActive = true
        cellView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
}
