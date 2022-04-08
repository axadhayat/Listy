//
//  DateHelpers.swift
//
//  Created by Asad Hayat on 11/03/2022.
//

import Foundation

class DateHelper{
    
    enum DateFormat:String{
        case server = "dd.MM.yyyy HH:mm"
        case year = "dd MMMM, HH:mm a"
        case year24 = "dd MMMM, HH:mm"
        case nonYear = "dd MMMM yyyy, HH:mm a"
        case nonYear24 = "dd MMMM yyyy, HH:mm"
    }
    
    static var is24HourFormat: Bool{
        let formatString = DateFormatter.dateFormat(
            fromTemplate: "j",
            options: 0,
            locale: Locale.current
        )!
        return formatString.contains("a")
    }
    
    private func getFormatter(withFormat format:DateFormat) -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.timeZone = TimeZone.init(identifier: "UTC")
        formatter.locale = .current
        return formatter
    }
    
    func getDate(from dateString:String) -> String{
        let serverFormatter = getFormatter(withFormat: .server)
        let formater = getFormatter(withFormat: .nonYear)
        guard let articleDate = serverFormatter.date(from: dateString) else { return dateString}
        if articleDate.isInThisYear{
            formater.dateFormat = DateHelper.is24HourFormat ? DateFormat.year24.rawValue : DateFormat.year.rawValue
        }
        else if DateHelper.is24HourFormat{
            formater.dateFormat = DateFormat.year24.rawValue
        }
        return formater.string(from: articleDate)
    }
}
