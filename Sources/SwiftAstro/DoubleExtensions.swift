//
//  File.swift
//  
//
//  Created by Ben Sinclair on 1/14/21.
//

import Foundation

extension Double {
    
    /// Rounds to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    /// Convert to degrees
    public var degrees: Double { return self * .pi / 180 }
    /// Convert to radians
    public var rad: Double { return self * 180 / .pi }
   
}
