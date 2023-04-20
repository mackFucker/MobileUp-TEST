//
//  NetworkManager.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 20.04.2023.
//

import UIKit



final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let mainURL: String = "https://rickandmortyapi.com/api/character/"
    
    func getResultStruct(token: String, completion: @escaping (Result<Welcome, Error>) -> Void) {
        getData(url: URL(string:"https://api.vk.com/method/photos.get?access_token=\(token)&owner_id=-128666765&album_id=266310117&v=5.131")!, completion: completion)
    }
    
     func getData<T:Decodable>(url: URL, completion: @escaping (Result<T,Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else { return }
            
            completion(.success(decodedData))
        }
        task.resume()
    }
}
