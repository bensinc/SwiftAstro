import XCTest
@testable import SwiftAstro

final class SwiftAstroTests: XCTestCase {
    
    func testEaster() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        let easterDate = formatter.date(from: "2000/04/23")!
        XCTAssertEqual(AstroDate.dateOfEaster(year: 2000).toDate(), easterDate)
    }

    func testDayNumber() {
        XCTAssertEqual(AstroDate(month: 5, day: 13, year: 2000).dayNumber(), 134)
        XCTAssertEqual(AstroDate(month: 12, day: 24, year: 2005).dayNumber(), 358)
    }

    func testJulianDayNumber() {
        XCTAssertEqual(AstroDate(month: 2, day: 17, year: 1985, hour: 6).julianDayNumber(), 2446113.75)
        XCTAssertEqual(AstroDate(month: 12, day: 31, year: 1979).julianDayNumber(), 2444238.5)
    }

    func testJulianDayToDate() {
        XCTAssertEqual(AstroDate(month: 2, day: 17, year: 1985, hour: 6), AstroDate.julianDayToDate(jd: 2446113.75))
    }

    func testDayOfWeek() {
        XCTAssertEqual(AstroDate(month: 2, day: 17, year: 1985).dayOfWeek(), "Sunday")
    }

    func testDecimalTime() {
        XCTAssertEqual(AstroDate(hour: 18, minute: 31, second: 27.0).decimalTime(), 18.5241666666666666)
    }

    func testDecimalTimeToDate() {
        XCTAssertEqual(AstroDate(hour: 18, minute: 31, second: 26.999999999997613), AstroDate.decimalTimeToDate(decimalTime: 18.5241666666666666))
    }
    
    func testGMTtoGST() {
        let date = AstroDate(month: 4, day: 22, year: 1980, hour: 14, minute: 36, second: 51.670)
        let gstDate = AstroDate(month: 4, day: 22, year: 1980, hour: 4, minute: 40, second: 5.165)
        XCTAssertEqual(date.gmtToGST(), gstDate)
    }
    
    func testGSTtoGMT() { 
        let date = AstroDate(month: 4, day: 22, year: 1980, hour: 4, minute: 40, second: 5.17)
        let gmtDate = AstroDate(month: 4, day: 22, year: 1980, hour: 14, minute: 36, second: 51.703)
        XCTAssertEqual(date.gstToGMT(), gmtDate)
    }
    
    func testB() {
        let date = AstroDate(month: 1, day: 1, year: 1979)
        XCTAssertEqual(date.calculateConstB(date: date).rounded(toPlaces: 6), 17.395559)
    }
    
    func testLocalSiderealTime() {
        let gstTime = AstroDate(hour: 4, minute: 40, second: 5.17)
        XCTAssertEqual(gstTime.gstToLST(toLon: -64), AstroDate(hour: 0, minute: 24, second: 5.1699999999991775))
    }
    
    func testLocalSiderealTimeToGST() {
        let gstTime = AstroDate(hour: 0, minute: 24, second: 5.17)
        XCTAssertEqual(gstTime.lstToGST(fromLon: -64), AstroDate(hour: 4, minute: 40, second: 5.169999999998964))
    }

    static var allTests = [
        ("testB", testB),
        ("easter", testEaster),
        ("dayNumber", testDayNumber),
        ("julianDayNumber", testJulianDayNumber),
        ("julianDayToDate", testJulianDayToDate),
        ("dayOfWeek", testDayOfWeek),
        ("decimalTime", testDecimalTime),
        ("decimalTimeToDate", testDecimalTimeToDate),
        ("GMTToGST", testGMTtoGST),
        ("GSTToGMT", testGSTtoGMT),
        ("localSiderealTime", testLocalSiderealTime),
        ("localSidealToGST", testLocalSiderealTimeToGST)

    ]
}
