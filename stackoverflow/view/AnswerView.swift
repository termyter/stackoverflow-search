//
//  AnswerView.swift
//  stackoverflow
//
//  Created by termyter on 18.07.2022.
//

import Foundation
import UIKit


class AnswerView: UIView {
    private var bodyText = UILabel()
    private var nameText = UILabel()
    var image = UIImageView()
    private var dateText = UILabel()
    private var scoreText = UILabel()
    var model: AnswerModel = AnswerModel.empty {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YYY"
            image.load(urlString: model.image)
            formatter.string(from: model.date)
            nameText.text = NSLocalizedString("name_text", comment: "") + model.name
            dateText.text = NSLocalizedString("date_text", comment: "") + formatter.string(from: model.date)
            bodyText.text = model.body
            scoreText.text =  NSLocalizedString("score_text", comment: "") + String(model.score)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        layer.cornerRadius = 14
        layer.shadowRadius = 14
//        setupTitleText()
        setupImage()
        setupNameText()
        setupDateText()
        setupScoreText()
        setupBodyText()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

        addSubview(image)
        image.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        image.leadingAnchor.constraint( equalTo: leadingAnchor, constant: 10).isActive = true
        image.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 60).isActive = true
    }

    private func setupNameText() {
        nameText.translatesAutoresizingMaskIntoConstraints = false

        addSubview(nameText)
        nameText.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        nameText.leadingAnchor.constraint( equalTo: image.trailingAnchor, constant: 10).isActive = true
        nameText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    private func setupDateText() {
        dateText.translatesAutoresizingMaskIntoConstraints = false

        addSubview(dateText)
        dateText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 5).isActive = true
        dateText.leadingAnchor.constraint( equalTo: image.trailingAnchor, constant: 10).isActive = true
        dateText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    private func setupScoreText() {
        scoreText.translatesAutoresizingMaskIntoConstraints = false

        addSubview(scoreText)
        scoreText.topAnchor.constraint(equalTo: dateText.bottomAnchor, constant: 5).isActive = true
        scoreText.leadingAnchor.constraint( equalTo: image.trailingAnchor, constant: 10).isActive = true
        scoreText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    private func setupBodyText() {
        bodyText.translatesAutoresizingMaskIntoConstraints = false
        bodyText.frame = CGRect(x: 0, y: 0, width: 100, height: 100)


        bodyText.translatesAutoresizingMaskIntoConstraints = false

        bodyText.numberOfLines = 0
        let maximumLabelSize: CGSize = CGSize(width: 280, height: 9999)
        let expectedLabelSize: CGSize = bodyText.sizeThatFits(maximumLabelSize)
        // create a frame that is filled with the UILabel frame data
        var newFrame: CGRect = bodyText.frame
        // resizing the frame to calculated size
        newFrame.size.height = expectedLabelSize.height
        // put calculated frame into UILabel frame
        bodyText.frame = newFrame

        addSubview(bodyText)
        bodyText.topAnchor.constraint(equalTo: scoreText.bottomAnchor, constant: 5).isActive = true
        bodyText.leadingAnchor.constraint( equalTo: leadingAnchor, constant: 5).isActive = true
        bodyText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        bodyText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }

}
