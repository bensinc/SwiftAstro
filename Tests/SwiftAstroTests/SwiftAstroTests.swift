import XCTest
@testable import SwiftAstro

final class SwiftAstroTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftAstro().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
