//
//  LocalRepository.swift
//
//  Created by Asad Hayat on 11/03/2022.
//

import Foundation
import CoreData

final class LocalRepository : BaseRepository{
    
    func getAll(completion:@escaping Completion) {
        var models:[Article] = []
        if let result = DatabaseManger.shared.fetch(managedObject: CDModel.self) {
            result.forEach { cdModel in
                let model = Article.init(id: nil, title: cdModel.title, dateTime: cdModel.dateTime, tags: [], content: [], ingress: nil, image: nil, imageData: cdModel.image, descrip: cdModel.descrip, created: nil, changed: nil)
                models.append(model)
            }
        }
        completion(.success(models))
    }
    
    func sync(article: Article) {
        
        if let _id = article.id{
            if !DatabaseManger.shared.isDuplicateRecord(for: _id){
                let cdModel = CDModel(context: DatabaseManger.shared.context)
                cdModel.id = article.id!
                cdModel.title = article.title
                cdModel.dateTime = article.dateTime
                cdModel.descrip = article.content.first?.description ?? article.ingress ?? ""
                DownloadManager.shared.downloadImage(from: URL.init(string: article.image!)!) { image in
                    cdModel.image = image?.pngData()
                    DatabaseManger.shared.saveContext()
                }
            }
        }
    }
}

