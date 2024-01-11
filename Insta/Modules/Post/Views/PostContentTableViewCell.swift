//
//  PostContentTableViewCell.swift
//  Insta
//
//  Created by Alex on 3/26/21.
//

import UIKit
import SnapKit
import SDWebImage
import AVFoundation

final class PostContentTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    private var postImageView: UIImageView!
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
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
        postImageView.image = nil
    }
    
    //MARK: - Setup
    
    private func setupSubviews() {
        contentView.layer.addSublayer(playerLayer)
        
        postImageView = {
            let i = UIImageView()
            i.contentMode = .scaleAspectFill
            i.backgroundColor = nil
            i.clipsToBounds = true
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
        postImageView.image = UIImage(named: "test")
        
        return
//        switch post.postType {
//        case .photo:
//            self.postImageView.sd_setImage(with: post.postURL)
//        case .video:
//            // load and play video
//            self.player = AVPlayer(url: post.postURL)
//            playerLayer.player = self.player
//            playerLayer.player?.volume = 0
//            playerLayer.player?.play()
//        }
    }
    
}
