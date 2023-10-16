//  
//  ExploreView.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import UIKit

final class ExploreView: UIView {
    
    //MARK: - Properties
    
    var collectionView: UICollectionView!
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
//        setupConstraints()
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
        
        collectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 1
            layout.minimumInteritemSpacing = 1
            layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.registerCell(PhotoCollectionViewCell.self)
            return collectionView
        }()
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.frame = bounds
    }
    
}



