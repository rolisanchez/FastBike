import XCTest
@testable import FastBike

class TrentinoBikeStationServiceTest: XCTestCase {

    func testPopulatingEmptyBikeService() {
        let expectation = XCTestExpectation(description: "Download data")
        
        let controller = SpyBikeStationServiceDelegate()
        controller.expectation = expectation
        
        let service = TrentinoBikeStationService(url: URL(string: "https://www.apple.com")!)
        
        service.getStations(delegate: controller)
        
        wait(for: [expectation], timeout: 10.0)
        XCTAssert(controller.setBikeStationsCalled)
    }
    
    func testPopulatingBikeService() {
        let expectation = XCTestExpectation(description: "Download data")

        let controller = SpyBikeStationServiceDelegate()
        controller.expectation = expectation
        let service = TrentinoBikeStationService(url: URL(string: "https://os.smartcommunitylab.it/core.mobility/bikesharing/lavis")!)
        
        service.getStations(delegate: controller)

//        service.populateBikeStations(with: [])
        wait(for: [expectation], timeout: 10.0)
        XCTAssert(controller.setBikeStationsCalled)
    }

    class SpyBikeStationServiceDelegate: BikeStationServiceDelegate {
        var setBikeStationsCalled = false
        var expectation: XCTestExpectation?
        
        func set(bikeStations: [BikeStation]) {
            print("entered")
            setBikeStationsCalled = true
            expectation?.fulfill()
        }
    }
}
