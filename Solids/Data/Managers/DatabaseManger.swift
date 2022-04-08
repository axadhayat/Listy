//
//  DataBaseHelper.swift
//
//  Created by Asad Hayat on 10/03/2022.
//

import CoreData

final class DatabaseManger{
    
    private init(){}
    static let shared = DatabaseManger()
    lazy var context = persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Solids")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
}

extension DatabaseManger{
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

extension DatabaseManger{
    
    func fetch<T:NSManagedObject> (managedObject:T.Type) -> [T]? {
        do {
            guard let result = try context.fetch(managedObject.fetchRequest()) as? [T] else{ return nil }
            return result
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    func isDuplicateRecord(for id: Int64) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CDModel")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let result = try context.fetch(fetchRequest)
            return result.count > 0 ? true : false
        }
        catch _ {
            return false
        }
    }
}
