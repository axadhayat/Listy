//
//  DataManager.swift
//
//  Created by Asad Hayat on 10/03/2022.
//

import Foundation


final class DataManager {
    
    private let remoteRepository:BaseRepository
    private let localRepositry:BaseRepository
    
    init(remoteRepo:BaseRepository = RemoteRespository()
         ,localrepo:BaseRepository = LocalRepository()){
        remoteRepository = remoteRepo
        localRepositry = localrepo
    }
    
    func fetchRecord(completion:@escaping Completion){
        remoteRepository.getAll { [weak self] remoteResult in
            guard let self = self else { return }
            switch remoteResult{
            case .success(let articles):
                let articles = articles ?? []
                self.syncRecord(articles: articles)
                completion(.success(articles))
            case .failure:
                self.localRepositry.getAll { localResult in
                    completion(localResult)
                }
            }
        }
    }
    
    func syncRecord(articles:[Article]){
        articles.forEach { article in
            localRepositry.sync(article: article)
        }
    }
}
