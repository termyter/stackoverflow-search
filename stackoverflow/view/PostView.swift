//
//  PostView.swift
//  stackoverflow
//
//  Created by termyter on 20.07.2022.
//

import Foundation

import UIKit



class PostView: UIView {
    private var titleText = UILabel()
    private var bodyText = UILabel()
    private var nameText = UILabel()
    private var image = UIImageView()
    private var dateText = UILabel()
    private var answerCount = UILabel()
    var model: PostModel = PostModel.empty {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YYY"
            titleText.text = model.title
            image.load(urlString: model.image)
            nameText.text = "Автор:" + model.name
            dateText.text = "Дата: " + formatter.string(from: model.date)
            answerCount.text = "Кол-во ответов: " + String(model.answer_count)
            bodyText.text = model.body
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupTitleText()
        setupImage()
        setupNameText()
        setupDateText()
        setupAnswerCount()
        setupBodyText()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTitleText() {
        titleText.translatesAutoresizingMaskIntoConstraints = false

        titleText.numberOfLines = 0
        let maximumLabelSize: CGSize = CGSize(width: 280, height: 9999)
        let expectedLabelSize: CGSize = titleText.sizeThatFits(maximumLabelSize)
        var newFrame: CGRect = titleText.frame
        newFrame.size.height = expectedLabelSize.height
        titleText.frame = newFrame

        addSubview(titleText)
        titleText.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleText.leadingAnchor.constraint( equalTo: leadingAnchor, constant: 10).isActive = true
        titleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }

    private func setupImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

        addSubview(image)
        image.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 5).isActive = true
        image.leadingAnchor.constraint( equalTo: leadingAnchor, constant: 10).isActive = true
        image.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 60).isActive = true
        //image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }

    private func setupNameText() {
        nameText.translatesAutoresizingMaskIntoConstraints = false

        addSubview(nameText)
        nameText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 5).isActive = true
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

    private func setupAnswerCount() {
        answerCount.translatesAutoresizingMaskIntoConstraints = false

        addSubview(answerCount)
        answerCount.topAnchor.constraint(equalTo: dateText.bottomAnchor, constant: 5).isActive = true
        answerCount.leadingAnchor.constraint( equalTo: image.trailingAnchor, constant: 10).isActive = true
        answerCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
//        answerCount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
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
        bodyText.topAnchor.constraint(equalTo: answerCount.bottomAnchor, constant: 5).isActive = true
        bodyText.leadingAnchor.constraint( equalTo: leadingAnchor, constant: 5).isActive = true
        bodyText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        bodyText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }

}
