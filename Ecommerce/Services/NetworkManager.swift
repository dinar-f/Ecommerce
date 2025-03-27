//
//  NetworkManager.swift
//  Ecommerce
//
//  Created by Dinar on 23.03.2025.
//

private let baseURL = "https://api.escuelajs.co/api/v1/products"

//enum UrlPaths: String {
//    case category = "https://api.escuelajs.co/api/v1/products"
//    case products = "https://api.escuelajs.co/api/v1/products"
//}

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func request(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("asdasd")
                return
            }
            do {
                let result = try JSONDecoder.init().decode([Product].self, from: data)
//                print(result)
                completion(.success(result))
            } catch {
                print(error.localizedDescription)
            }
           
        }
        task.resume()
    }
}
