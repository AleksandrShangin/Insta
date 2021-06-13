//
//  NoNotificationsView.swift
//  Insta
//
//  Created by Alex on 4/22/21.
//

import UIKit
import ColorCompatibility



final class NoNotificationsView: UIView {

    // MARK: - UI
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "No Notifications Yet"
        label.textColor = ColorCompatibility.secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = ColorCompatibility.secondaryLabel
        imageView.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "bell")
        } else {
            // Fallback on earlier versions
        }
        return imageView
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (width-50)/2, y: 0, width: 50, height: 50).integral
        label.frame = CGRect(x: 0, y: imageView.bottom, width: width, height: height-50).integral
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
