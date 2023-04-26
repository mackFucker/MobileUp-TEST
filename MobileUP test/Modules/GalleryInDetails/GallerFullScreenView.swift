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
    func saveSuccesIndicatorShowAndHide()
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
        collectionView.register(GalleryFullScreenCell.self, forCellWithReuseIdentifier: GalleryFullScreenCell.identifer)
        addSubview(collectionView)
        return collectionView
    }()
    
    private lazy var saveSuccesIndicator: UIImageView = {
        let saveSuccesIndicator = UIImageView()
        saveSuccesIndicator.backgroundColor = .systemGray2
        saveSuccesIndicator.layer.cornerRadius = 12
        saveSuccesIndicator.alpha = 0.8
        saveSuccesIndicator.isHidden = true
        saveSuccesIndicator.image = UIImage(systemName: "square.and.arrow.down")
        saveSuccesIndicator.tintColor = .systemGray
        saveSuccesIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(saveSuccesIndicator)
        return saveSuccesIndicator
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            saveSuccesIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveSuccesIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            saveSuccesIndicator.heightAnchor.constraint(equalToConstant: 100),
            saveSuccesIndicator.widthAnchor.constraint(equalToConstant: 100)
        ])
        
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
    
    func saveSuccesIndicatorShowAndHide() {
        UIView.transition(with: saveSuccesIndicator, duration: 0.3, options: .transitionCrossDissolve) {
            self.saveSuccesIndicator.isHidden = false
        }
                UIView.animate(withDuration: 1, delay: 0.3, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
                    self.saveSuccesIndicator.alpha = 0
                }, completion: { finished in
                    self.saveSuccesIndicator.isHidden = true
                    self.saveSuccesIndicator.alpha = 1
                })
    }
}
