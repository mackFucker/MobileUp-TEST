//
//  Model.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 20.04.2023.
//

import UIKit

struct ViewModel {
    let id: Int
    let image: String
}

protocol DataSource: AnyObject {
    func getData(token: String)
    func setupDelegate(delegate: GalleryViewControllerInput)
}

final class DataSourceImpl: DataSource {
   
    static let shared = DataSourceImpl()
    private weak var delegate: GalleryViewControllerInput?

    private init () {}
        
    func getData(token: String) {
        let url = "https://api.vk.com/method/photos.get?access_token=\(token)&owner_id=-128666765&album_id=266310117&v=5.131"
        NetworkManager.shared.getResultStruct(url: url ) { result in
            switch result {
                case .success(let success):
                let viewModels = success.response.items.map { ViewModel(id: $0.id, image: $0.sizes[3].url) }
                    self.delegate?.getDataArray(viewModel: viewModels)
                case .failure:
                    break
            }
        }
    }
    
    func setupDelegate(delegate: GalleryViewControllerInput) {
        self.delegate = delegate
    }
}

