//
//  HorizonCoordinate.swift
//  
//
//  Created by Ben Sinclair on 1/21/21.
//

import Foundation

///  🌎 Represents a set of horizon coordinates
class HorizonCoordinate : Equatable, CustomStringConvertible {
    var altitude: HMS
    var azimuth: HMS
    
    public var description: String { return "HorizonCoordinate: alt: \(altitude.hours):\(altitude.minutes):\(altitude.seconds), az: \(azimuth.hours):\(azimuth.minutes):\(azimuth.seconds)" }
    
    init(altitude: HMS, azimuth: HMS) {
        self.altitude = altitude
        self.azimuth = azimuth
    }
    
    //MARK: Equatable
    
    static func == (lhs: HorizonCoordinate, rhs: HorizonCoordinate) -> Bool {
        return lhs.altitude == rhs.altitude && lhs.azimuth == rhs.azimuth
    }
    
    func toEquatorialCoordinate(date: AstroDate, latitude: Double) -> EquatorialCoordinate {
        let φ = latitude
        
        let A = self.azimuth.toDecimal()
        
        let a = self.altitude.toDecimal()
        
        let sinδ = sin(a.degrees) * sin(φ.degrees) + cos(a.degrees) * cos(φ.degrees) * cos(A.degrees)
        
        let δ = asin(sinδ).rad
        
        let cosH = (sin(a.degrees) - sin(φ.degrees) * sin(δ.degrees)) / (cos(φ.degrees) * cos(δ.degrees))
        
        var H = acos(cosH).rad
        
        let sinA = sin(A.degrees)
        if (sinA > 0) {
            H = 360.0 - H
        }
        
        H /= 15.0
        
        let hmsH = HMS(decimal: H)
        let hmsδ = HMS(decimal: δ)
        
        let lst = date.decimalTime()
        var α = lst - H
        if (α < 0) {
            α += 24
        }
        let hmsα = HMS(decimal: α)
        
        return(EquatorialCoordinate(rightAscension: hmsα, declination: hmsδ))
    }
    
}
