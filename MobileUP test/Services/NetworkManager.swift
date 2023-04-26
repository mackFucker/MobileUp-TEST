//
//  NetworkManager.swift
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

struct User: Codable {
    let response: [ResponseUser]
}

struct ResponseUser: Codable {
    let id: Int
    let firstName, lastName: String
    let canAccessClosed, isClosed: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func checkToken(token: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = URL(string: "https://api.vk.com/method/users.get?access_token=\(token)&v=5.131")!
        getData(url: url, completion: completion)
    }
    
    func getResultStruct(url: String, completion: @escaping (Result<Welcome, Error>) -> Void) {
        getData(url: .init(string: url)!, completion: completion)
    }

     func getData<T:Decodable>(url: URL, completion: @escaping (Result<T,Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
         
        task.resume()
    }
}

