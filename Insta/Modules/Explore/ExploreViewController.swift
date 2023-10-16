//
//  ExploreViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit

final class ExploreViewController: UIViewController {

    // MARK: - Properties
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    private weak var collectionView: UICollectionView!
    
    private let viewModel: ExploreViewModel
    private var router: ExploreRouter!
    
    // MARK: - Init
    
    init(viewModel: ExploreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = ExploreView()
        self.view = view
        self.collectionView = view.collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRouter()
        configureViews()
    }
    
    // MARK: - Configure
    
    private func configureRouter() {
        router = ExploreRouter(viewController: self)
    }
    
    private func configureViews() {
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

}

extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        self.cancelSearch()
        self.query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.cancelSearch()
    }
    
    private func cancelSearch() {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    private func query(_ text: String) {
        // perform search in back end
        
    }
}


extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(PhotoCollectionViewCell.self, indexPath: indexPath)
        
        cell.configure(debug: "test")
        return cell
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.router.showPost()
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
