//
//  HMS.swift
//  
//
//  Created by Ben Sinclair on 1/21/21.
//

import Foundation

///  🕒 Represents a coordinate (or time) in hours, minutes, and seconds
class HMS : Comparable, Equatable, CustomStringConvertible {
    var hours: Int
    var minutes: Int
    var seconds: Double
    
    public var description: String { return "HMS: \(hours):\(minutes):\(seconds)" }
    
    
    //MARK: Initializers
    
    /**
         Initializes a new HMS with the specified hours, minutes, and seconds

         - Returns: A new HMS object
     */
    init(hours: Int, minutes: Int, seconds: Double) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    /**
         Initializes a new HMS from the specified decimal hours

         - Returns: A new HMS object
     */
    init(decimal: Double) {
        let f = decimal.truncatingRemainder(dividingBy: 1) * 60.0
        hours = Int(decimal)
        minutes = Int(f)
        seconds = f.truncatingRemainder(dividingBy: 1) * 60.0
    }
    
    //MARK: Comparable
    
    static func < (lhs: HMS, rhs: HMS) -> Bool {
        if lhs.hours != rhs.hours {
            return lhs.hours < rhs.hours
        } else if lhs.minutes != rhs.minutes {
            return lhs.minutes < rhs.minutes
        } else {
            return lhs.seconds < rhs.seconds
        }
    }
    
    //MARK: Equatable
    
    static func == (lhs: HMS, rhs: HMS) -> Bool {
        return lhs.hours == rhs.hours && lhs.minutes == rhs.minutes
            && lhs.seconds == rhs.seconds
    }
    
    /**
         Converts HMS into decimal hours

         - Returns: Decimal hours
     */
    func toDecimal() -> Double {
        var d = Double(seconds) / 60.0
        
        d += Double(minutes)
        d /= 60.0
        d += Double(hours)
        return(d)
    }
    
    var debugDescription: String {
        return "HMS: \(hours):\(minutes):\(seconds)"
    }

    
}
