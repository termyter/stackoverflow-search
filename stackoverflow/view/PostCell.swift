//
//  PostCell.swift
//  stackoverflow
//
//  Created by termyter on 20.07.2022.
//

import Foundation
import UIKit

protocol PostViewDelegate: AnyObject {
    func klickImage(sender: UITapGestureRecognizer)
}

class PostCell: UITableViewCell, PostViewDelegate {
    func klickImage(sender: UITapGestureRecognizer) {
        postCellDelegate?.klickImage(sender: sender)
    }
    
    var postCellDelegate: PostCellDelegate?
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
        cellView.postViewDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        
        let marginGuide = contentView.layoutMarginsGuide
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cellView)
        cellView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -5).isActive = true
        cellView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
    }
}
