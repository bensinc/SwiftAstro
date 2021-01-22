//
//  File.swift
//  
//
//  Created by Ben Sinclair on 1/21/21.
//

import Foundation

///  🔭 Represents a set of equatorial coordinates
class EquatorialCoordinate {
    
    var rightAscension: HMS
    var declination: HMS
    
    init(rightAscension: HMS, declination: HMS) {
        self.rightAscension = rightAscension
        self.declination = declination
    }
    
    /**
         Calculates the hour angle of this coordinate for a time and longitude
         - Returns: HMS
     */
    func localHourAngle(date: AstroDate, longitude: Double) -> HMS {
        let lst = date.gmtToGST().gstToLST(toLon: longitude).decimalTime()
        let da = self.rightAscension.toDecimal()
        var h = lst - da
        if (h < 0) {
            h += 24
        }
        return(HMS(decimal: h))
    }
    
    /**
         Converst to horizon coordinate
         - Returns: HorizonCoordinate
     */
    func toHorizonCoordinate(date: AstroDate, latitude: Double, longitude: Double) -> HorizonCoordinate {
        
        let φ = latitude
        
        let Hd = localHourAngle(date: date, longitude: longitude).toDecimal() * 15.0
        
        let δ = declination.toDecimal()
        
        let sinA = sin(δ.degrees) * sin(φ.degrees) + cos(δ.degrees) * cos(φ.degrees) * cos(Hd.degrees)
        
        let a = asin(sinA).rad
                
        let cosA = ( sin(δ.degrees) - sin(φ.degrees) * sinA ) / (cos(φ.degrees) * cos(a.degrees))

        var A = acos(cosA).rad
        
        let sinH = sin(Hd.degrees)
        
        if (sinH > 0) {
            A = 360.0 - A
        }

        return HorizonCoordinate(altitude: HMS(decimal: a), azimuth: HMS(decimal: A))
    }
    
    /**
         Calculates the RA of an hour angle for a time and longitude
         - Returns: HMS
     */
    static func localHourAngleToRA(hourAngle: HMS, date: AstroDate, longitude: Double) -> HMS {
        let lst = date.gmtToGST().gstToLST(toLon: longitude).decimalTime()
        let h = hourAngle.toDecimal()
        var ra = lst - h
        if (ra < 0.0) {
            ra += 24.0
        }
        return(HMS(decimal: ra))
    }
    
}
