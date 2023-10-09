//
//  ListViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit

final class ListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let data: [UserRelationship]
        
    // MARK: - UI
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(UserFollowTableViewCell.self)
        return tableView
    }()
    
    // MARK: - Init
    
    init(data: [UserRelationship]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}



extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(UserFollowTableViewCell.self, indexPath: indexPath)
        cell.configure(with: data[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Go to profile of selected cell
        let model = data[indexPath.row]
    }
}



extension ListViewController: UserFollowTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserRelationship) {
        print("Follow button tapped :: status \(model.type)")
        switch model.type {
        case .following:
            // perform firebase update to unfollow
            break
        case .not_following:
            // perform firebase update to follow
            break
        }
    }
}







