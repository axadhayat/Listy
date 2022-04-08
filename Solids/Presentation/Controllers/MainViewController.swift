//
//  ViewController.swift
//  asadhayat
//
//  Created by Asad Hayat on 09/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

class MainViewController: UIViewController{

    // IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // Private Properties
    
    private let bag = DisposeBag()
    
    // View model is injected from scene delegate
    
    var viewModel:ListViewModel = ListViewModel()
    
    // life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBinding()
    }
    
    // Private Methods
    
    private func setupTableView() {
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        tableView.registerNib(from: MainTableViewCell.self)
    }
    
    private func setupBinding() {
        
        viewModel.articles.bind(to: tableView.rx.items(cellIdentifier: MainTableViewCell.identifier, cellType: MainTableViewCell.self)) { (row,article,cell) in
            cell.article = article
        }.disposed(by: bag)
        viewModel.error.observe(on: MainScheduler.instance).subscribe { [weak self] error in
            guard let self = self else { return }
            guard let alertMessage = error.element else { return }
            self.alert(alertMessage: alertMessage)
        }.disposed(by: bag)
        viewModel.fetchList()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 326
    }
}
