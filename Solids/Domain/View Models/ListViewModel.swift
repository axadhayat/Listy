//
//  ViewModel.swift
//
//  Created by Asad Hayat on 09/03/2022.
//

import Foundation
import RxSwift
import Network

protocol ViewModel{
    associatedtype T
    var articles: PublishSubject<[T]> { get set }
    var error: PublishSubject<String> { get set }
}

class ListViewModel : ViewModel{
    
    // Properties

    internal var articles = PublishSubject<[Article]>()
    internal var error = PublishSubject<String>()
    private var dataManager:DataManager!
    
    // Init

    init(manager:DataManager = DataManager()){
        dataManager = manager
    }
    
    // Fetching list from database or remote resource

    func fetchList() {
        dataManager.fetchRecord { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let articles):
                self.articles.onNext(articles ?? [])
                self.articles.onCompleted()
            case .failure(let error):
                self.error.onNext(error.localizedDescription)
                self.error.onCompleted()
            }
        }
    }
}

