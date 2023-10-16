//
//  UserFollowTableViewCell.swift
//  Insta
//
//  Created by Alex on 4/15/21.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationship)
}

final class UserFollowTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var profileImageView: UIImageView!
    private var nameLabel: UILabel!
    private var usernameLabel: UILabel!
    private var followButton: UIButton!
    
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    //MARK: - Setup
    
    private func setupSubviews() {
        contentView.clipsToBounds = true
        selectionStyle = .none
        
        profileImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.backgroundColor = .secondarySystemBackground
            return imageView
        }()
        contentView.addSubview(profileImageView)
        
        nameLabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            label.text = "Joe"
            return label
        }()
        contentView.addSubview(nameLabel)
        
        usernameLabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.font = .systemFont(ofSize: 16, weight: .regular)
            label.text = "@joe"
            label.textColor = .secondaryLabel
            return label
        }()
        contentView.addSubview(usernameLabel)
        
        followButton = {
            let button = UIButton()
            button.backgroundColor = .link
            button.addTarget(
                self,
                action: #selector(didTapFollowButton),
                for: .touchUpInside
            )
            return button
        }()
        contentView.addSubview(followButton)
    }
    
    private func setupConstraints() {
        profileImageView.frame = CGRect(
            x: 3,
            y: 3,
            width: contentView.height - 6,
            height: contentView.height - 6
        )
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let labelHeight = contentView.height / 2
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width / 3
        nameLabel.frame = CGRect(
            x: profileImageView.right + 5,
            y: 0,
            width: contentView.width - 8 - profileImageView.width-buttonWidth,
            height: labelHeight
        )
        usernameLabel.frame = CGRect(
            x: profileImageView.right + 5,
            y: nameLabel.bottom,
            width: contentView.width - 8 - profileImageView.width-buttonWidth,
            height: labelHeight
        )
        
        followButton.frame = CGRect(
            x: contentView.width - 5 - buttonWidth,
            y: (contentView.height - 40) / 2,
            width: buttonWidth,
            height: 40
        )
    }
    
    //MARK: - Actions
    
    @objc
    private func didTapFollowButton() {
        guard let model = model else { return }
        print("Tapped")
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    //MARK: - Configure
    
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type {
        case .following:
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    
}
