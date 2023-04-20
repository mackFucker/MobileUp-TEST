//
//  Model.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 20.04.2023.
//

import UIKit

struct Welcome: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let albumID, date, id, ownerID: Int
    let sizes: [Size]
    let text: String
    let userID: Int
    let hasTags: Bool

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let type: TypeEnum
    let width: Int
    let url: String
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

struct ViewModel {
    let id: Int
    let image: String
}

protocol ModelDelegate: AnyObject {
    func getData(token: String)
    func setupDelegate(delegate: GalleryViewControllerInput)
}

final class ModelDataSource: ModelDelegate {
   
    static let shared = ModelDataSource()
    private weak var delegate: GalleryViewControllerInput?

    private init () {}
        
    func getData(token: String) {
        NetworkManager.shared.getResultStruct(token: token) { result in
            switch result {
                case .success(let success):
                let viewModels = success.response.items.map {ViewModel(id: $0.id, image: $0.sizes[0].url)}
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

