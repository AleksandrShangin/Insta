//
//  PostHeaderTableViewCell.swift
//  Insta
//
//  Created by Alex on 3/26/21.
//

import UIKit
import SDWebImage

protocol PostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton(_ cell: UITableViewCell, user: User)
}

class PostHeaderTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var userImageView: UIImageView!
    private var usernameLabel: UILabel!
    private var moreButton: UIButton!
    
    weak var delegate: PostHeaderTableViewCellDelegate?
    var user: User?
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        usernameLabel.text = nil
        
    }
    
    //MARK: - Setup
    
    private func setupSubviews() {
        userImageView = {
            let i = UIImageView()
            i.contentMode = .scaleAspectFill
            i.layer.cornerRadius = 25
            i.layer.masksToBounds = true
            return i
        }()
        contentView.addSubview(userImageView)
        
        usernameLabel = {
            let i = UILabel()
            i.textColor = .label
            i.numberOfLines = 1
            i.font = .systemFont(ofSize: 18, weight: .medium)
            return i
        }()
        contentView.addSubview(usernameLabel)
        
        moreButton = {
            let i = UIButton()
            i.tintColor = .label
            i.setImage(UIImage(systemName: "ellipsis"), for: .normal)
            i.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
            return i
        }()
        contentView.addSubview(moreButton)
    }
    
    private func setupConstraints() {
        userImageView.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.left.equalTo(userImageView.snp.right).offset(10)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(moreButton.snp.left)
        }
        
        moreButton.snp.makeConstraints {
            $0.right.equalTo(-10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
    
    //MARK: - Actions
    
    @objc
    private func moreButtonTapped() {
        guard let user = user else {
            return
        }
        delegate?.didTapMoreButton(self, user: user)
    }
    
    //MARK: - Configure
    
    public func configure(with user: User) {
        self.user = user
        userImageView.image = UIImage(named: "test")
//        userImageView.sd_setImage(with: user.profilePhoto)
        usernameLabel.text = user.username
    }

}
