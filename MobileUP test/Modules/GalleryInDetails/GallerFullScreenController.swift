//
//  GalleryInDetailsViewController.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 19.04.2023.
//

import UIKit
import SDWebImage

final class GallerFullScreenController: UIViewController {
    
    private var  gallerFullScreenView: GallerFullScreenViewInput { view as! GallerFullScreenViewInput }
    private var viewModels: [ViewModel]
    private let index: CGFloat
    var itemIndex: CGFloat = 0
    
    init(viewModels: [ViewModel], index: CGFloat) {
        self.viewModels = viewModels
        self.index = index
        super.init(nibName: nil, bundle: nil)
                
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
        title = "\(viewModels[Int(index)].date)"

         gallerFullScreenView.setCollectionViewSources(source: self)
    }
    
    private lazy var shareNavigatonBarButton: UIBarButtonItem = {
        let shareNavigatonBarButton = UIBarButtonItem(title: nil,
                                         style: .plain,
                                         target: self,
                                         action: #selector(presentShareSheet))
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
    private func presentShareSheet(_ sender: UIButton) {
        let image = UIImageView()
        
        if itemIndex.isNaN {
            image.sd_setImage(with: .init(string: viewModels[0].image))
        }
        else {
            image.sd_setImage(with: .init(string: viewModels[Int(itemIndex)].image))
        }
        
        let url = URL(string: "https://vk.com")
        
        let shareSheetVC = UIActivityViewController(activityItems: [image.image as Any, url as Any],
                                                    applicationActivities: nil)
        shareSheetVC.popoverPresentationController?.sourceView = sender
        shareSheetVC.popoverPresentationController?.sourceRect = sender.frame
        present(shareSheetVC, animated: true)
    }
    
}

extension GallerFullScreenController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        itemIndex = scrollView.contentOffset.x / scrollView.frame.width

        if itemIndex.truncatingRemainder(dividingBy: 1) == 0 {
            let index = Int(itemIndex)
            title = "\(viewModels[index].date)"
        }
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








