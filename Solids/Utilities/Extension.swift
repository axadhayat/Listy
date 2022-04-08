//
//  Helpers.swift
//
//  Created by Asad Hayat on 11/03/2022.
//

import UIKit

extension UITableView {
    func registerNib(from cellClass: UITableViewCell.Type) {
        let identifier = cellClass.identifier
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

extension NSObjectProtocol {
    static var identifier: String { return String(describing: self) }
}

extension UIViewController {
    func alert(alertText : String = "Alert", alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension Date {
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    var isInThisYear:  Bool { isInSameYear(as: Date()) }
}

extension UIViewController{
    class func instantiate<T: UIViewController>() -> T? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}

