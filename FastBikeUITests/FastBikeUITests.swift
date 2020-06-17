//
//  FastBikeUITests.swift
//  FastBikeUITests
//
//  Created by Victor Rolando Sanchez Jara on 6/15/20.
//  Copyright © 2020 tm. All rights reserved.
//

import XCTest

class FastBikeUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testLaunchMapsFromApp() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let bicivuotaButton = app.buttons["bicivuota"]
        
        bicivuotaButton.tap()

        XCUIApplication().buttons["bicivuota"].tap()

        // If we reached here without error we are OK
        XCTAssert(true)
        
//        if app.alerts["Allow “Maps” to use your location?"].exists {
//            print("exists")
//            app.alerts["Allow “Maps” to use your location?"].scrollViews.otherElements.buttons["Allow Once"].tap()
//        } else {
//            print("exists")
//        }
//
//        let button = app.buttons["GO"]
//
//        expectation(for: exists, evaluatedWith: button, handler: nil)
//        waitForExpectations(timeout: 15, handler: nil)
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
