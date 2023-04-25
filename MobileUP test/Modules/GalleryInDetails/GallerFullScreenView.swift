//
//  GalleryInDetailsView.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 19.04.2023.
//

import UIKit

protocol GallerFullScreenViewInput: UIView {
    func setCollectionViewSources(source: CollectionViewSources)
    func colectionViewReloadData()
}

final class GallerFullScreenView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
                
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(GalleryInDetailsCell.self, forCellWithReuseIdentifier: GalleryInDetailsCell.identifer)
        addSubview(collectionView)
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = frame
    }
}

extension GallerFullScreenView: GallerFullScreenViewInput {
    
    func setCollectionViewSources(source: CollectionViewSources) {
        collectionView.dataSource = source
        collectionView.delegate = source
    }
    
    func colectionViewReloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
