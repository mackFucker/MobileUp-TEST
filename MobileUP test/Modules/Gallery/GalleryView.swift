//
//  GalleryView.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 19.04.2023.
//

import UIKit

protocol GalleryViewInput: UIView {
    func setCollectionViewSources(source: CollectionViewSources)
}

typealias CollectionViewSources = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

final class GalleryView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifer)
        addSubview(collectionView)
        return collectionView
    }()
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension GalleryView: GalleryViewInput {
    func setCollectionViewSources(source: CollectionViewSources) {
        collectionView.delegate = source
        collectionView.dataSource = source
    }
    
}

