//
//  RemoteRespository.swift
//
//  Created by Asad Hayat on 11/03/2022.
//

import Foundation

final class RemoteRespository:BaseRepository{
    
    func getAll(completion:@escaping Completion) {
        guard let baseUrl = preparaBaseUrl(with: "v3/c6ee7715-d606-49dd-a282-ac6ce2f0e7f0") else { return }
        ApiManager.shared.request(url: baseUrl) { (result: Response<BaseResponse>) in
            switch result{
            case .success(let response):
                completion(.success(response.content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func preparaBaseUrl(with path:String) -> URL?{
        if let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL"){
            if let baseUrlStr = baseUrl as? String{
                let absoluteUrl = baseUrlStr + path
                return URL.init(string: absoluteUrl)
            }
        }
        return nil
    }
    
    func sync(article: Article) {
        // sync record if needed
    }
}
