//
//  FollowersListViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit

final class FollowersListViewController: UIViewController {
    
    // MARK: - Properties
    
    private weak var tableView: UITableView!
    
    private let viewModel: FollowersListViewModel
    
    // MARK: - Init
    
    init(viewModel: FollowersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = FollowersListView()
        self.view = view
        self.tableView = view.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}



extension FollowersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(UserFollowTableViewCell.self, indexPath: indexPath)
        cell.configure(with: viewModel.data[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Go to profile of selected cell
        let model = viewModel.data[indexPath.row]
    }
}



extension FollowersListViewController: UserFollowTableViewCellDelegate {
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
