//  
//  HomeView.swift
//  Insta
//
//  Created by Alexander Shangin on 12.10.2023.
//

import UIKit

final class HomeView: UIView {
    
    //MARK: - Properties
    
    var tableView: UITableView!
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    private func setupSubviews() {
        tableView = {
            let tableView = UITableView()
            tableView.registerCell(PostHeaderTableViewCell.self)
            tableView.registerCell(PostContentTableViewCell.self)
            tableView.registerCell(PostActionsTableViewCell.self)
            tableView.registerCell(PostCommentsTableViewCell.self)
            return tableView
        }()
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}



