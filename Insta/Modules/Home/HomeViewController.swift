//
//  ViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

final class HomeViewController: UIViewController {

    // MARK: - Properties
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    
    // MARK: - UI
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerCell(PostHeaderTableViewCell.self)
        tableView.registerCell(PostContentTableViewCell.self)
        tableView.registerCell(PostActionsTableViewCell.self)
        tableView.registerCell(PostCommentsTableViewCell.self)
        return tableView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    
    // MARK: - Private Methods
    
    private func createMockData() {
        let user = User(
            username: "@kanye_west",
            bio: "", name: (first: "", last: ""),
            profilePhoto: URL(string: "https://www.google.com")!,
            birthDate: Date(),
            gender: .male,
            counts: UserCount(followers: 1, following: 1, posts: 1),
            joinDate: Date()
        )
        let post = UserPost(
            identifier: "",
            postType: .photo,
            thumbnailImage: URL(string: "https://www.google.com")!,
            postURL: URL(string: "https://www.google.com")!,
            caption: nil,
            likedCount: [],
            comments: [],
            postedDate: Date(),
            taggedUsers: [],
            owner: user
        )
        
        
        for x in 0...4 {
            let viewModel = HomeFeedRenderViewModel(
                header: PostRenderViewModel(renderType: .header(provider: user)),
                post: PostRenderViewModel(renderType: .primaryContent(content: post)),
                actions: PostRenderViewModel(renderType: .actions(provider: "")),
                comments: PostRenderViewModel(renderType: .comments(comments: [
                    PostComment(
                        identifier: "123_\(x)",
                        username: "@dave",
                        text: "Great post!",
                        postedDate: Date(),
                        likes: []
                    ),
                    PostComment(
                        identifier: "123_\(x)",
                        username: "@dave",
                        text: "Great post!",
                        postedDate: Date(),
                        likes: []
                    ),
                ]))
                )
            feedRenderModels.append(viewModel)
        }
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false, completion: nil)
        }
    }

}



// MARK: - Extension for TableView Methods

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model: HomeFeedRenderViewModel
        if section == 0 {
            model = feedRenderModels[0]
        } else {
            let position = section % 4 == 0 ? section / 4 : (section - (section % 4)) / 4
            model = feedRenderModels[position]
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
            model = feedRenderModels[0]
        } else {
            let position = indexPath.section % 4 == 0 ? indexPath.section / 4 : (indexPath.section - (indexPath.section % 4)) / 4
            model = feedRenderModels[position]
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
