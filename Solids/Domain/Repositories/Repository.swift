//
//  Respositry.swift
//
//  Created by Asad Hayat on 10/03/2022.
//

import Foundation

typealias Completion = (Result<[Article]?, Error>) -> Void

protocol FetchProtocol{
    func getAll(completion:@escaping Completion)
}

protocol SyncProtocol{
    func sync(article : Article)
}

protocol BaseRepository : FetchProtocol & SyncProtocol {}
