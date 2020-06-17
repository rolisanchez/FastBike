import XCTest
@testable import FastBike

class TrentinoBikeStationServiceTest: XCTestCase {

    func testPopulatingBikeService() {
        print("testPopulatingBikeService")
        let controller = SpyBikeStationServiceDelegate()
        let service = TrentinoBikeStationService(url: URL(string: "https://www.apple.com")!)
        service.getStations(delegate: controller)

//        service.populateBikeStations(with: [])
        
        XCTAssert(controller.setBikeStationsCalled)
    }

    class SpyBikeStationServiceDelegate: BikeStationServiceDelegate {
        var setBikeStationsCalled = false

        func set(bikeStations: [BikeStation]) {
            print("entered")
            setBikeStationsCalled = true
        }
    }
}
