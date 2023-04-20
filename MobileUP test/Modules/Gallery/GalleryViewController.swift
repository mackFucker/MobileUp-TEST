//
//  GalleryViewController.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 19.04.2023.
//

import UIKit

protocol GalleryViewControllerInput: AnyObject {
    func getDataArray(viewModel: [ViewModel])
}

final class GalleryViewController: UIViewController {
    
    private var viewModels = [ViewModel]()
    private var modelRepository: ModelDelegate = ModelDataSource.shared
    private let galleryView: GalleryViewInput
    
    init(galleryView: GalleryViewInput, token: String) {
        self.galleryView = galleryView
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "MobileUp Gallery"
        
        modelRepository.setupDelegate(delegate: self)
        modelRepository.getData(token: token)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = galleryView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        galleryView.setCollectionViewSources(source: self)

    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifer,
                                                 for: indexPath as IndexPath) as! CollectionViewCell
        cell.setup(viewModel: viewModels[indexPath.row])
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 1, bottom: 1, right: 1)
    }
}

extension GalleryViewController: GalleryViewControllerInput {
    func getDataArray(viewModel: [ViewModel]) {
        self.viewModels = viewModel
    }
}
