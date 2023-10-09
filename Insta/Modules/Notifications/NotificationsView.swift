//  
//  NotificationsView.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import UIKit

final class NotificationsView: UIView {
    
    //MARK: - Properties
    
    var noNotificationsView: NoNotificationsView!
    var tableView: UITableView!
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: - Setup
    
    private func setupSubviews() {
        backgroundColor = .systemBackground
        
        tableView = {
            let tableView = UITableView()
            tableView.registerCell(NotificationLikeEventTableViewCell.self)
            tableView.registerCell(NotificationFollowEventTableViewCell.self)
            tableView.isHidden = true
            return tableView
        }()
        addSubview(tableView)
        
        noNotificationsView = {
            let i = NoNotificationsView()
            i.isHidden = true
            return i
        }()
        addSubview(noNotificationsView)
    }
    
    private func setupConstraints() {
        tableView.frame = bounds
        
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: self.width/2, height: self.width/4)
        noNotificationsView.center = center
    }
    
}



