//
//  PostContentTableViewCell.swift
//  Insta
//
//  Created by Alex on 3/26/21.
//

import UIKit
import SnapKit

final class PostContentTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    private var postImageView: UIImageView!
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    private func setupSubviews() {
        contentView.backgroundColor = .secondarySystemBackground
        
        postImageView = {
            let i = UIImageView()
            
            return i
        }()
        contentView.addSubview(postImageView)
    }
    
    private func setupConstraints() {
        postImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - Configure
    
    public func configure(with post: UserPost) {
        // configure the cell
        
    }
    
}
