//  
//  FollowersListView.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import UIKit

final class FollowersListView: UIView {
    
    //MARK: - Properties
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(UserFollowTableViewCell.self)
        return tableView
    }()
    
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
        
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.frame = bounds
    }
    
}



