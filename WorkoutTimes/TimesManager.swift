//
//  TimesManager.swift
//  WorkoutTimes
//
//  Created by Jason Philpy on 2/7/21.
//

import Foundation

class TimesManager {
    var times: [WorkoutTime]
    var dbManager: DBManager
    

    init(dataStack: CoreDataStack) {
        dbManager = DBManager(dataStack: dataStack)
        times = dbManager.getList()
    }
  
    func addTime(name:String, duration: TimeInterval)  {
        if let time = dbManager.create() {
            time.name = name
            time.duration = duration
            time.date = Date()
            times.append(time)
            dbManager.save()
        }
    }
    
    func updateTime(time: WorkoutTime, duration: TimeInterval) {
        time.duration = duration
        dbManager.save()
    }
    
    func removeTime(index: Int) {
        if index < times.count {
            let time = times[index]
            if dbManager.remove(instance: time) {
                times.remove(at: index)
            }
        }
    }
}
