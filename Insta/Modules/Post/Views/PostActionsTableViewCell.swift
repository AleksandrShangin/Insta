//
//  PostActionsTableViewCell.swift
//  Insta
//
//  Created by Alex on 3/26/21.
//

import UIKit

class PostActionsTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostActionsTableViewCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // configure the cell
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
