//
//  PostCommentsTableViewCell.swift
//  Insta
//
//  Created by Alex on 3/26/21.
//

import UIKit
import SnapKit

class PostCommentsTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var userLabel: UILabel!
    private var commentLabel: UILabel!
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    private func setupSubviews() {
        contentView.backgroundColor = .systemOrange
        userLabel = {
            let i = UILabel()
            
            return i
        }()
        contentView.addSubview(userLabel)
        commentLabel = {
            let i = UILabel()
            
            return i
        }()
        contentView.addSubview(commentLabel)
    }
    
    private func setupConstraints() {
        userLabel.setContentHuggingPriority(.required, for: .horizontal)
        userLabel.snp.makeConstraints {
            $0.left.equalTo(8)
            $0.centerY.equalToSuperview()
        }
        
        commentLabel.snp.makeConstraints {
            $0.left.equalTo(userLabel.snp.right).offset(8)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(-8)
        }
    }
    
    //MARK: - Configure
    
    public func configure(with comment: PostComment) {
        // configure the cell
        userLabel.text = comment.username
        commentLabel.text =  comment.text
    }
    
}
