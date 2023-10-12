//
//  ViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit
import Combine
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

final class HomeViewController: UIViewController {

    // MARK: - Properties
    
    private var tableView: UITableView!
    
    private let viewModel: HomeViewModel
    private var router: HomeRouter!
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = HomeView()
        self.view = view
        self.tableView = view.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRouter()
        configureViews()
        configureBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    
    // MARK: - Private Methods
    
    private func configureRouter() {
        router = HomeRouter(viewController: self)
    }
    
    private func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureBindings() {
        viewModel.feedRenderModels
            .sink { [weak self] models in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            router.showLogin()
        }
    }

}



// MARK: - Extension for TableView Methods

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.feedRenderModels.value.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model: HomeFeedRenderViewModel
        if section == 0 {
            model = viewModel.feedRenderModels.value[0]
        } else {
            let position = section % 4 == 0 ? section / 4 : (section - (section % 4)) / 4
            model = viewModel.feedRenderModels.value[position]
        }
        
        let subSection = section % 4
        
        if subSection == 0 {
            // header
            return 1
            
        } else if subSection == 1 {
            // post
            return 1
            
        } else if subSection == 2 {
            // actions
            return 1
        } else if subSection == 3 {
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            default:
                fatalError()
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: HomeFeedRenderViewModel
        if indexPath.section == 0 {
            model = viewModel.feedRenderModels.value[0]
        } else {
            let position = indexPath.section % 4 == 0 ? indexPath.section / 4 : (indexPath.section - (indexPath.section % 4)) / 4
            model = viewModel.feedRenderModels.value[position]
        }
        
        let subSection = indexPath.section % 4
        
        if subSection == 0 {
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueCell(PostHeaderTableViewCell.self, indexPath: indexPath)
                cell.delegate = self
                cell.configure(with: user)
                return cell
            default:
                fatalError()
            }
        } else if subSection == 1 {
            switch model.post.renderType {
            case .primaryContent(let content):
                let cell = tableView.dequeueCell(PostContentTableViewCell.self, indexPath: indexPath)
                cell.configure(with: content)
                return cell
            default:
                fatalError()
            }
        } else if subSection == 2 {
            switch model.actions.renderType {
            case .actions(let actions):
                let cell = tableView.dequeueCell(PostActionsTableViewCell.self, indexPath: indexPath)
                cell.delegate = self
                return cell
            default:
                fatalError()
            }
        } else if subSection == 3 {
            switch model.comments.renderType {
            case .comments(let comments):
//                return comments.count > 2 ? 2 : comments.count
                let cell = tableView.dequeueCell(PostCommentsTableViewCell.self, indexPath: indexPath)
                
                cell.configure(with: comments.first!)
                return cell
            default:
                fatalError()
            }
        }
        
        return UITableViewCell()
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            return 70
        } else if subSection == 1 {
            return tableView.width
        } else if subSection == 2 {
            return 60
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
    
}

extension HomeViewController: PostHeaderTableViewCellDelegate {
    func didTapMoreButton(_ cell: UITableViewCell, user: User) {
        print(#function)
        showAlert(
            title: "Post Options",
            preferredStyle: .actionSheet,
            actions: [
                UIAlertAction(title: "Report Post", style: .destructive) { [weak self] _ in
                    
                },
                UIAlertAction(title: "Cancel", style: .cancel)
            ]
        )
    }
}

extension HomeViewController: PostActionsTableViewCellDelegate {
    func didTapLikeButton(_ cell: PostActionsTableViewCell) {
        print(#function)
    }
    
    func didTapCommentButton(_ cell: PostActionsTableViewCell) {
        print(#function)
    }
    
    func didTapSendButton(_ cell: PostActionsTableViewCell) {
        print(#function)
    }
}
