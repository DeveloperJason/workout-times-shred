//
//  TestCoreDataStack.swift
//  WorkoutTimesTests
//
//  Created by Jason Philpy on 2/7/21.
//

import Foundation
import CoreData
@testable import WorkoutTimes

class TestCoreDataStack: CoreDataStack {
    override init() {
        super.init()

        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: "WTModel")
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer = container
    }
}
