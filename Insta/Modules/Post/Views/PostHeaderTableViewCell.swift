//
//  PostHeaderTableViewCell.swift
//  Insta
//
//  Created by Alex on 3/26/21.
//

import UIKit

class PostHeaderTableViewCell: UITableViewCell {
    
    private var userImageView: UIImageView!
    private var userLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.backgroundColor = .systemBlue
        userImageView = {
            let i = UIImageView()
            i.contentMode = .scaleAspectFill
            i.image = UIImage(named: "test")
            i.layer.cornerRadius = 25
            i.layer.masksToBounds = true
            return i
        }()
        addSubview(userImageView)
        
        userLabel = {
            let i = UILabel()
            
            return i
        }()
        addSubview(userLabel)
    }
    
    private func setupConstraints() {
        userImageView.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        userLabel.snp.makeConstraints {
            $0.left.equalTo(userImageView.snp.right).offset(10)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(-10)
        }
    }
    
    public func configure(with user: User) {
//        userImageView.sd_setImage(with: user.profilePhoto)
        userLabel.text = user.username
    }

}
