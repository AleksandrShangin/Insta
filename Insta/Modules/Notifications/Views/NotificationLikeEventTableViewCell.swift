//
//  NotificationLikeEventTableViewCell.swift
//  Insta
//
//  Created by Alex on 4/22/21.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

final class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    
    // MARK: - Properties
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    // MARK: - UI
    
    private var profileImageView: UIImageView!
    private var label: UILabel!
    private var postButton: UIButton!
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupSubviews() {
        contentView.clipsToBounds = true
        selectionStyle = .none
        
        profileImageView = {
            let imageView = UIImageView()
            imageView.layer.masksToBounds = true
            imageView.backgroundColor = .tertiarySystemBackground
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        contentView.addSubview(profileImageView)
        
        label = {
            let label = UILabel()
            label.textColor = .label
            label.numberOfLines = 0
            label.text = "@joe liked your photo."
            return label
        }()
        contentView.addSubview(label)
        
        postButton = {
            let button = UIButton()
            button.setBackgroundImage(UIImage(named: "test"), for: .normal)
            button.addTarget(
                self,
                action: #selector(didTapPostButton),
                for: .touchUpInside
            )
            return button
        }()
        contentView.addSubview(postButton)
        
    }
    
    private func setupConstraints() {
        profileImageView.frame = CGRect(
            x: 3,
            y: 3,
            width: contentView.height - 6,
            height: contentView.height - 6
        )
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let size: CGFloat = contentView.height-4
        postButton.frame = CGRect(
            x: contentView.width-5-size,
            y: 2,
            width: size,
            height: size
        )
        
        label.frame = CGRect(
            x: profileImageView.right + 5,
            y: 0,
            width: contentView.width - size - profileImageView.width - 16,
            height: contentView.height
        )
    }
    
    // MARK: - Configure
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else { return }
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
        case .follow:
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        label.text = nil
        postButton.backgroundColor = nil
    }

    
    // MARK: - Actions
    
    @objc
    private func didTapPostButton() {
        guard let model = model else { return }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
}
