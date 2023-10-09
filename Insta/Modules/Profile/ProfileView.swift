//  
//  ProfileView.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import UIKit

final class ProfileView: UIView {
    
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
            // Cell
            collectionView.register(
                PhotoCollectionViewCell.self,
                forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
            )
            // Headers
            collectionView.register(
                ProfileInfoHeaderCollectionReusableView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier
            )
            collectionView.register(
                ProfileTabsCollectionReusableView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: ProfileTabsCollectionReusableView.identifier
            )
            return collectionView
        }()
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.frame = bounds
    }
    
}



