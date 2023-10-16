//
//  ProfileViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit

/// Profile view controller
final class ProfileViewController: UIViewController {

    // MARK: - Properties
    
    private var userPosts = [UserPost]()
    
    private weak var collectionView: UICollectionView!
    
    private let viewModel: ProfileViewModel
    private var router: ProfileRouter!
    
    // MARK: - Init
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = ProfileView()
        self.view = view
        self.collectionView = view.collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRouter()
        configureNavigationBar()
        configureViews()
    }
    
    //MARK: - Configure
    
    private func configureRouter() {
        router = ProfileRouter(viewController: self)
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTapSettings)
        )
    }
    
    private func configureViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    //MARK: - Actions
    
    @objc
    private func didTapSettings() {
        self.router.showSettings()
    }
    
}

//MARK: - Extension for UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
//        return userPosts.count
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueCell(PhotoCollectionViewCell.self, indexPath: indexPath)
//        cell.configure(with: model)
        cell.backgroundColor = .systemBlue
        cell.configure(debug: "test")
        return cell
    }
}

//MARK: - Extension for UICollectionViewDelegate

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        // get the model and open post controller
//        let model = userPosts[indexPath.row]
        self.router.showPost()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            // footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            // tabs header
            let tabControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            tabControlHeader.delegate = self
            return tabControlHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        profileHeader.delegate = self
        return profileHeader
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        }
        
        // Size of section tabs
        return CGSize(width: collectionView.width, height: 50)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = (view.width - 4) / 3
        return CGSize(width: size, height: size)
    }
    
}


// MARK: - ProfileInfoHeaderCollectionReusableViewDelegate

extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        // scroll to the posts
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        self.router.showFollowers()
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        self.router.showFollowing()
    }
    
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        self.router.showEditProfile()
    }
}


extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    func didTapGridButtonTab() {
        // Reload collection view with data
        
    }
    
    func didTapTaggedButtonTab() {
        // Reload collection view with data
        
    }
}



