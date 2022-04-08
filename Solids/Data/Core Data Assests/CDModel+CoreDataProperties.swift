//
//  CDModel+CoreDataProperties.swift
//  
//
//  Created by Asad Hayat on 08/04/2022.
//
//

import Foundation
import CoreData


extension CDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDModel> {
        return NSFetchRequest<CDModel>(entityName: "CDModel")
    }

    @NSManaged public var dateTime: String?
    @NSManaged public var descrip: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: Data?
    @NSManaged public var title: String?

}
