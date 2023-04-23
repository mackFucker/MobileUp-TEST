//
//  GalleryView.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 19.04.2023.
//

import UIKit

protocol GalleryViewInput: UIView {
    func setCollectionViewSources(source: CollectionViewSources)
    func colectionViewReloadData()
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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifer)
        addSubview(collectionView)
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = frame
    }
}

extension GalleryView: GalleryViewInput {
    func setCollectionViewSources(source: CollectionViewSources) {
        collectionView.delegate = source
        collectionView.dataSource = source
    }
    
    func colectionViewReloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

