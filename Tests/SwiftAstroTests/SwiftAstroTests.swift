import XCTest
@testable import SwiftAstro

final class SwiftAstroTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftAstro().text, "Hello, World!")
    }
    
    func testEaster() {
        let astro = SwiftAstro()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let easterDate = formatter.date(from: "2000/04/23")!
        XCTAssertEqual(astro.dateOfEaster(year: 2000), easterDate)
    }

    static var allTests = [
        ("easter", testEaster),
    ]
}
