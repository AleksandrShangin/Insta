//
//  PostViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit

final class PostViewController: UIViewController {

    // MARK: - Properties
    
    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    
    // MARK: - UI
    
    private var tableView: UITableView!
    
    private let viewModel: PostViewModel
    
    // MARK: - Init
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        self.model = viewModel.userPost
        self.renderModels = viewModel.renderModels
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = PostView()
        self.view = view
        self.tableView = view.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Private Methods
    
    private func configureModels() {
        guard let userPostModel = self.model else { return }
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(content: userPostModel)))
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        // 4 Comments
        var comments = [PostComment]()
        for x in 1...4 {
            comments.append(PostComment(identifier: "123_\(x)",
                                        username: "@dave",
                                        text: "Great post!",
                                        postedDate: Date(),
                                        likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }

}



// MARK: - TableView Extension

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .header:
            return 1
        case .primaryContent:
            return 1
        case .actions:
            return 1
        case .comments(let comments):
            return comments.count > 4 ? 4 : comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .header(let user):
            let cell = tableView.dequeueCell(PostHeaderTableViewCell.self, indexPath: indexPath)
            cell.configure(with: user)
            return cell
        case .primaryContent(let post):
            let cell = tableView.dequeueCell(PostContentTableViewCell.self, indexPath: indexPath)
            
            return cell
        case .actions(let actions):
            let cell = tableView.dequeueCell(PostActionsTableViewCell.self, indexPath: indexPath)
            
            return cell
        case .comments(let comments):
            print(comments)
            let cell = tableView.dequeueCell(PostCommentsTableViewCell.self, indexPath: indexPath)
            let comment = comments[indexPath.row]
            cell.configure(with: comment)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions:
            return 60
        case .comments:
            return 50
        case .primaryContent:
            return tableView.width
        case .header:
            return 70
        }
    }
    
}
