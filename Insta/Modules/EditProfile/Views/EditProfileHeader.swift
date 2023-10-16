//
//  EditProfileHeader.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import UIKit
import FirebaseAuth
import SDWebImage

final class EditProfileHeaderTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    private var userImageView: UIImageView!

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
    
    // MARK: - Setup
    
    private func setupSubviews() {
        contentView.backgroundColor = .gray
        isUserInteractionEnabled = false
        
        userImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .systemBackground
            imageView.contentMode = .scaleAspectFill
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.borderWidth = 3
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = imageView.width / 2
            return imageView
        }()
        contentView.addSubview(userImageView)
    }
    
    private func setupConstraints() {
        let imageSize: CGFloat = 170
        userImageView.frame = CGRect(
            x: (contentView.width-imageSize) / 2,
            y: contentView.height / 2 - imageSize / 2,
            width: imageSize,
            height: imageSize
        )
        userImageView.layer.cornerRadius = userImageView.width/2
    }
    
    func configure(with url: URL?) {
        self.userImageView.sd_setImage(with: url)
    }
    
}

