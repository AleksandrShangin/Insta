//
//  NotificationsViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit
import Combine

final class NotificationsViewController: UIViewController {
    
    // MARK: - Properties
    
    private weak var noNotificationsView: NoNotificationsView!
    private weak var tableView: UITableView!
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private let viewModel: NotificationsViewModel
    private var router: NotificationsRouter!
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: NotificationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = NotificationsView()
        self.view = view
        self.noNotificationsView = view.noNotificationsView
        self.tableView = view.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRouter()
        configureNavigationBar()
        configureViews()
        configureBindings()
        fetchNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    // MARK: - Configure
    
    private func configureRouter() {
        router = NotificationsRouter(viewController: self)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Notifications"
    }
    
    private func configureViews() {
        view.addSubview(spinner)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureBindings() {
        viewModel.isLoading
            .sink { [weak self] in
                $0 ? self?.spinner.startAnimating() : self?.spinner.stopAnimating()
            }
            .store(in: &subscriptions)
        
        viewModel.notifications
            .sink { [weak self] notifications in
                if !notifications.isEmpty {
                    self?.tableView.isHidden = false
                    self?.noNotificationsView.isHidden = true
                    self?.tableView.reloadData()
                } else {
                    self?.tableView.isHidden = true
                    self?.noNotificationsView.isHidden = false
                }
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Load Data
    
    private func fetchNotifications() {
        viewModel.fetchNotifications()
    }
    
}



extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notifications.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.notifications.value[indexPath.row]
        switch model.type {
        case .like(_):
            // like cell
            let cell = tableView.dequeueCell(NotificationLikeEventTableViewCell.self, indexPath: indexPath)
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            // follow cell
            let cell = tableView.dequeueCell(NotificationFollowEventTableViewCell.self, indexPath: indexPath)
            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}


extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        print("Tapped post")
        switch model.type {
        case .like(let post):
            self.router.showPost(post: post)
        case .follow(_):
            fatalError("Dev Issue: Should never get called")
        }
    }
}


extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("Tapped follow unfollow button")
        // perform database update
    }
}
