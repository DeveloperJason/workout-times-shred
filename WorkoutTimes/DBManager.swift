//
//  File.swift
//  WorkoutTimes
//
//  Created by Jason Philpy on 2/5/21.
//

import UIKit
import CoreData

class DBManager {

    var coreData: CoreDataStack
    var context: NSManagedObjectContext
    
    init(dataStack: CoreDataStack) {
        coreData = dataStack
        context = coreData.persistentContainer.viewContext
    }
    
    func create()-> WorkoutTime? {
        return NSEntityDescription.insertNewObject(forEntityName: "WorkoutTime", into: context) as? WorkoutTime
    }
    
    func getList() -> [WorkoutTime] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WorkoutTime")
        request.returnsObjectsAsFaults = false
        var results: [WorkoutTime] = try! context.fetch(request) as! [WorkoutTime]
        results = results.sorted(by: {
            $0.date!.compare($1.date!) == .orderedAscending
        })
        return results
    }
    
    func save() {
        try? context.save()
    }
    
    func remove(instance: NSManagedObject) -> Bool {
        context.delete(instance)
        do {
            try context.save()
        } catch _ {
            return false
        }
        return true
    }
    
}
