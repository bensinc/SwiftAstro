import XCTest
@testable import SwiftAstro

final class SwiftAstroTests: XCTestCase {
    
    func testEaster() {
        let astro = SwiftAstro()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let easterDate = formatter.date(from: "2000/04/23")!
        XCTAssertEqual(astro.dateOfEaster(year: 2000), easterDate)
    }

    func testDayNumber() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: "2000/5/13")!
        XCTAssertEqual(date.dayNumber(), 134)

        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy/MM/dd"
        let date2 = formatter.date(from: "2005/12/24")!
        XCTAssertEqual(date2.dayNumber(), 358)
    }

    func testJulianDayNumber() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        let date = formatter.date(from: "1985/2/17 06:00")!
        XCTAssertEqual(date.julianDayNumber(), 2446113.75)

        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy/MM/dd hh:mm"
        let date2 = formatter2.date(from: "1979/12/31 12:00")!
        XCTAssertEqual(date2.julianDayNumber(), 2444238.5)
    }

    func testJulianDayToDate() {
        let astro = SwiftAstro()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        let date = formatter.date(from: "1985/2/17 06:00")!
        XCTAssertEqual(date, astro.julianDayToDate(jd: 2446113.75))
    }

    func testDayOfWeek() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: "2021/1/13")!
        XCTAssertEqual(date.dayOfWeek(), "Wednesday")
    }

    func testDecimalTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = formatter.date(from: "1985/2/17 18:31:27")!
        XCTAssertEqual(date.decimalTime(), 18.5241666666666666)
    }

    func testDecimalTimeToDate() {
        let astro = SwiftAstro()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = formatter.date(from: "1980/01/01 18:31:26")!
        XCTAssertEqual(date, astro.decimalTimeToDate(decimalTime: 18.5241666666666666))
    }
    
    func testGMTtoGST() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        let date = formatter.date(from: "1980/04/22 14:36:51.670")!
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        let gstDate = formatter.date(from: "1980/04/22 04:40:4.493")!

        XCTAssertEqual(date.gmtToGST(), gstDate)
    }
    
    func testGSTtoGMT() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        let date = formatter.date(from: "1980/04/22 04:40:5.17")!
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        let gstDate = formatter.date(from: "1980/04/22 14:36:51.534")!
        
        XCTAssertEqual(date.gstToGMT(), gstDate)
    }
    
    func testB() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        let date = formatter.date(from: "1979/01/01 00:00:00.000")!
        XCTAssertEqual(SwiftAstro().calculateConstB(date: date).rounded(toPlaces: 6), 17.395559)
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

    ]
}
