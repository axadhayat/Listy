//
//  ApiManager.swift
//
//  Created by Asad Hayat on 10/03/2022.
//

import Foundation

// Response

typealias RequestResponse<T> = ((Result<T, Error>) -> Void)
typealias Response<T> = (Result<T, Error>)

// Network Service

protocol ApiService{
    func request<T:Codable> (url:URL , completion:@escaping RequestResponse<T>)
}

final class ApiManager:ApiService{
    
    private init(){}
    static let shared = ApiManager()
    
    func request<T:Codable> (url:URL , completion:@escaping RequestResponse<T>){
        URLSession.shared.dataTask(with: url) { data, response, anomaly in
            if let error = anomaly {
                completion(.failure(error))
            }
            guard let jsonData = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                completion(.success(result))
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
