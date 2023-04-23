//
//  GalleryViewController.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 19.04.2023.
//

import UIKit
import WebKit

protocol GalleryViewControllerInput: AnyObject {
    func getDataArray(viewModel: [ViewModel])
}

final class GalleryViewController: UIViewController {
    
    private var viewModels = [ViewModel]()
    private var modelRepository = DataSourceImpl.shared
    private var galleryView: GalleryViewInput { view as! GalleryViewInput }
    
    init(token: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "MobileUp Gallery"
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = exitButton
        
        modelRepository.setupDelegate(delegate: self)
        modelRepository.getData(token: token)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = GalleryView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryView.setCollectionViewSources(source: self)
    }
    
    @objc
    private func logOutOfYourAccount() {
        KeychainRepository.shared.deleteTokenFromKeychain(key: "token")
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
            print("All cookies deleted")

            WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
                records.forEach { record in
                    WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                    print("Cookie ::: \(record) deleted")
                }
            }
    }
    
    private lazy var exitButton: UIBarButtonItem = {
        let exitButton = UIBarButtonItem(title: "Выход",
                                         style: .plain,
                                         target: self,
                                         action: #selector(logOutOfYourAccount))
        exitButton.tintColor = .label
        return exitButton
    }()
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifer,
                                                      for: indexPath as IndexPath) as! CollectionViewCell
        cell.setup(viewModel: viewModels[indexPath.row])
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 1, bottom: 1, right: 1)
    }
}

extension GalleryViewController: GalleryViewControllerInput {
    func getDataArray(viewModel: [ViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.viewModels = viewModel
            self.galleryView.colectionViewReloadData()
        }
    }
}
