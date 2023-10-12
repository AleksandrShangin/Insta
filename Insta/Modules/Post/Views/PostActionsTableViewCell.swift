//
//  PostActionsTableViewCell.swift
//  Insta
//
//  Created by Alex on 3/26/21.
//

import UIKit
import SnapKit

protocol PostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton( _ cell: PostActionsTableViewCell)
    func didTapCommentButton( _ cell: PostActionsTableViewCell)
    func didTapSendButton( _ cell: PostActionsTableViewCell)
}

final class PostActionsTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    private var likeButton: UIButton!
    private var commentButton: UIButton!
    private var sendButton: UIButton!
    
    weak var delegate: PostActionsTableViewCellDelegate?
    
    let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
    
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
        
    }
    
    //MARK: - Setup
    
    private func setupSubviews() {
        likeButton = {
            let i = UIButton()
            let image = UIImage(systemName: "heart", withConfiguration: config)
            i.setImage(image, for: .normal)
            i.tintColor = .label
            i.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            return i
        }()
        contentView.addSubview(likeButton)
        
        commentButton = {
            let i = UIButton()
            let image = UIImage(systemName: "message", withConfiguration: config)
            i.setImage(image, for: .normal)
            i.tintColor = .label
            i.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
            return i
        }()
        contentView.addSubview(commentButton)
        
        sendButton = {
            let i = UIButton()
            let image = UIImage(systemName: "paperplane", withConfiguration: config)
            i.setImage(image, for: .normal)
            i.tintColor = .label
            i.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
            return i
        }()
        contentView.addSubview(sendButton)
    }
    
    private func setupConstraints() {
        likeButton.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.size.equalTo(30)
            $0.centerY.equalToSuperview()
        }
        
        commentButton.snp.makeConstraints {
            $0.left.equalTo(likeButton.snp.right).offset(12)
            $0.size.equalTo(30)
            $0.centerY.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints {
            $0.left.equalTo(commentButton.snp.right).offset(12)
            $0.size.equalTo(30)
            $0.centerY.equalToSuperview()
        }
    }
    
    //MARK: - Actions
    
    @objc
    private func likeButtonTapped() {
        delegate?.didTapLikeButton(self)
    }
    
    @objc
    private func commentButtonTapped() {
        delegate?.didTapCommentButton(self)
    }
    
    @objc
    private func sendButtonTapped() {
        delegate?.didTapSendButton(self)
    }
    
    //MARK: - Configure
    
    public func configure(with post: UserPost) {
        // configure the cell
        
    }

}
