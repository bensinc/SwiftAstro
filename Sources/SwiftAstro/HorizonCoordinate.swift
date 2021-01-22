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
    
}
