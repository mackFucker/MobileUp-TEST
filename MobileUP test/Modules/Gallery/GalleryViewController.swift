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
        navigationItem.rightBarButtonItem = exitNavigatonBarButton
        
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
    
    private lazy var exitNavigatonBarButton: UIBarButtonItem = {
        let exitButton = UIBarButtonItem(title: NSLocalizedString("Exit", comment: ""),
                                         style: .plain,
                                         target: self,
                                         action: #selector(logOutOfYourAccountPresentAlert))
        exitButton.tintColor = .label
        return exitButton
    }()
    
    @objc
    private func logOutOfYourAccountPresentAlert() {
        
        let alert = UIAlertController(title: NSLocalizedString("Exit", comment: ""), message: NSLocalizedString("Exit.alert.title", comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Exit", comment: ""), style: UIAlertAction.Style.destructive, handler: {action in self.logOutOfYourAccount()}))
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
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
        
        let vc = AuthenticationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryViewCell.identifer,
                                                      for: indexPath as IndexPath) as! GalleryViewCell
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

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = GallerFullScreenController(viewModels: viewModels, index: CGFloat(indexPath.row))
        self.navigationController?.pushViewController(vc, animated: true)
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
