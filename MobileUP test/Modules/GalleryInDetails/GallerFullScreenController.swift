//
//  GalleryInDetailsViewController.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 19.04.2023.
//

import UIKit

final class GallerFullScreenController: UIViewController {
    
    private var  GallerFullScreenView: GallerFullScreenViewInput { view as! GallerFullScreenViewInput }
    private var viewModels: [ViewModel]
    private let index: CGFloat
        
    init(viewModels: [ViewModel], index: CGFloat) {
        self.viewModels = viewModels
        self.index = index
        super.init(nibName: nil, bundle: nil)
        
        self.title = "date"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true

        navigationItem.rightBarButtonItem = shareNavigatonBarButton
        navigationItem.leftBarButtonItem = backNavigatonBarButton


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = GallerFullScreenView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
         GallerFullScreenView.setCollectionViewSources(source: self)
    }
    
    private lazy var shareNavigatonBarButton: UIBarButtonItem = {
        let shareNavigatonBarButton = UIBarButtonItem(title: nil,
                                         style: .plain,
                                         target: self,
                                         action: #selector(share))
        shareNavigatonBarButton.tintColor = .label
        shareNavigatonBarButton.image = UIImage(systemName: "square.and.arrow.up")
        return shareNavigatonBarButton
    }()
    
    private lazy var backNavigatonBarButton: UIBarButtonItem = {
        let backNavigatonBarButton = UIBarButtonItem(title: nil,
                                         style: .plain,
                                         target: self,
                                         action: #selector(back))
        backNavigatonBarButton.tintColor = .label
        backNavigatonBarButton.image = UIImage(systemName: "chevron.backward")
        return backNavigatonBarButton
    }()
    
    @objc
    private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func share() {
        navigationController?.dismiss(animated: true)
    }
    
}

extension GallerFullScreenController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let widht = collectionView.frame.width
        collectionView.contentOffset.x = widht * index
        return viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryInDetailsCell.identifer,
                                                      for: indexPath as IndexPath) as! GalleryInDetailsCell
        cell.setup(viewModel: viewModels[indexPath.row])

        return cell
    }
}

extension GallerFullScreenController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let heightPerItem = collectionView.frame.height
        let widthPerItem = collectionView.frame.width
        return CGSize(width: widthPerItem, height: heightPerItem - 200)
    }
}








