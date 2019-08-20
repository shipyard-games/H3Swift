import XCTest
@testable import H3Swift

final class H3SwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let geoCoord = H3.GeoCoord(lat: 60.1733244, lon: 24.9410248)
        let index = H3.Index.geoToH3(geoCoord, resolution: 10)
        
        let indices = index.kRing(k: 3)
        
        XCTAssertTrue(indices.count > 0)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
