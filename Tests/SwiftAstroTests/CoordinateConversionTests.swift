//
//  CoordinateConversionTests.swift
//  
//
//  Created by Ben Sinclair on 1/21/21.
//

import XCTest
@testable import SwiftAstro

final class CoordinateConversionTests: XCTestCase {
    
    func testRightAscensionToHourAngle() {
        let eq = EquatorialCoordinate(rightAscension: HMS(hours: 18, minutes: 32, seconds: 21.0), declination: HMS(decimal: 0.0))
        let longitude = -64.0
        let date = AstroDate(month: 4, day: 22, year: 1980, hour: 14, minute: 36, second: 51.67)        
        let h = eq.localHourAngle(date: date, longitude: longitude)
        XCTAssertEqual(h, HMS(hours: 5, minutes: 51, seconds:44.16500000000468))
    }
    
    func testHourAngleToRightAscension() {
       
        let hourAngle = HMS(hours: 5, minutes: 51, seconds: 44.0)
        let longitude = -64.0
        let date = AstroDate(month: 4, day: 22, year: 1980, hour: 14, minute: 36, second: 51.67)
        let ra = EquatorialCoordinate.localHourAngleToRA(hourAngle: hourAngle, date: date, longitude: longitude)
        XCTAssertEqual(ra, HMS(hours: 18, minutes: 32, seconds:21.165000000005136))
    }
    
    func testEquatorialToHorizon() {
        let eq = EquatorialCoordinate(rightAscension: HMS(hours: 18, minutes: 32, seconds: 21.0), declination: HMS(hours: 23, minutes: 13, seconds: 10))
        let date = AstroDate(month: 4, day: 22, year: 1980, hour: 14, minute: 36, second: 51.67)
        XCTAssertEqual(eq.toHorizonCoordinate(date: date, latitude: 52.0, longitude: -64.0), HorizonCoordinate(altitude: HMS(decimal: 19.333933260866129), azimuth: HMS(decimal: 283.27153493259442)))
    }



    static var allTests = [
        ("testRightAscensionToHourAngle", testRightAscensionToHourAngle),
        ("testHowAngleToRightAscension", testRightAscensionToHourAngle),
        ("testEquatorialToHorizon", testEquatorialToHorizon),

    ]
}
