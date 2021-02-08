//
//  WorkoutTimesTests.swift
//  WorkoutTimesTests
//
//  Created by Jason Philpy on 2/3/21.
//

import XCTest
import CoreData
import Firebolt
@testable import WorkoutTimes

class WorkoutTimesTests: XCTestCase {

    let resolver = Resolver()


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        resolver.register { TimesManager(dataStack: TestCoreDataStack()) }
    }

    override func tearDownWithError() throws {
        resolver.unregisterAllDependencies()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddTime() throws {
        let timeManager:TimesManager = resolver.get()
        timeManager.addTime(name: "test1", duration: 1.0)
        timeManager.addTime(name: "test2", duration: 20)
        let times = timeManager.dbManager.getList()
        XCTAssertNotNil(times, "Times should not be nil")
        XCTAssertTrue(times[0].name == "test1")
        XCTAssertTrue(times[0].duration == 1.0)
        XCTAssertTrue(times[1].name == "test2")
        XCTAssertTrue(times[1].duration == 20)
    }
    
    func testListing() throws {
        let timeManager:TimesManager = resolver.get()
        timeManager.addTime(name: "test1", duration: 1)
        timeManager.addTime(name: "test2", duration: 2)
        timeManager.addTime(name: "test3", duration: 3)
        timeManager.addTime(name: "test4", duration: 4)
        let times = timeManager.dbManager.getList()
        XCTAssertNotNil(times, "Times should not be nil")
        XCTAssertTrue(times.count == 4, "Should return 4 entries")
    }

    func testUpdateTime() throws {
        let timeManager:TimesManager = resolver.get()
        timeManager.addTime(name: "test1", duration: 1)
        let time = timeManager.dbManager.getList()[0]
        timeManager.updateTime(time: time, duration: 2)
        let newTime = timeManager.dbManager.getList()[0]
        XCTAssertTrue(newTime.duration == 2, "Should have updated value to 2")
    }
    
    func testRemoveTime() throws {
        let timeManager:TimesManager = resolver.get()
        timeManager.addTime(name: "test1", duration: 1)
        timeManager.addTime(name: "test2", duration: 2)
        timeManager.addTime(name: "test3", duration: 3)
        let times = timeManager.dbManager.getList()
        XCTAssertTrue(times[1].name == "test2", "Assuring that index 1 is test2")
        timeManager.removeTime(index: 1)
        let newTimes = timeManager.dbManager.getList()
        XCTAssertTrue(newTimes[1].name != "test2", "test2 should no longer be at index 1")
        XCTAssertTrue(newTimes.count == 2, "Count should have reduced to 2")
        XCTAssertTrue(newTimes[0].name == "test1")
        XCTAssertTrue(newTimes[1].name == "test3")

    }

}
