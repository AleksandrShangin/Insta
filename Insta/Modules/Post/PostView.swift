//  
//  PostView.swift
//  Insta
//
//  Created by Alexander Shangin on 10.10.2023.
//

import UIKit

final class PostView: UIView {
    
    //MARK: - Properties
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(PostContentTableViewCell.self)
        tableView.registerCell(PostHeaderTableViewCell.self)
        tableView.registerCell(PostActionsTableViewCell.self)
        tableView.registerCell(PostCommentsTableViewCell.self)
        return tableView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
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



