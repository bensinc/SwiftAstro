//
//  File.swift
//  
//
//  Created by Ben Sinclair on 1/14/21.
//

import Foundation

class AstroDate : Comparable, Equatable, CustomDebugStringConvertible {
    var month: Int
    var day: Int
    var year: Int
    
    var hour: Int
    var minute: Int
    var second: Double
    
    var debugDescription: String {
        return "AstroDate: \(month)/\(day)/\(year) \(hour):\(minute):\(second)"
    }
    
    
    //MARK: Initializers
    
    init(month: Int, day: Int, year: Int, hour: Int, minute: Int, second: Double) {
        self.month = month
        self.day = day
        self.year = year
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
    init(month: Int, day: Int, year: Int) {
        self.month = month
        self.day = day
        self.year = year
        self.hour = 0
        self.minute = 0
        self.second = 0.0
    }
    
    init(month: Int, day: Int, year: Int, hour: Int) {
        self.month = month
        self.day = day
        self.year = year
        self.hour = hour
        self.minute = 0
        self.second = 0.0
    }
    
    //MARK: Comparable
    
    static func < (lhs: AstroDate, rhs: AstroDate) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        } else if lhs.month != rhs.month {
            return lhs.month < rhs.month
        } else {
            return lhs.day < rhs.day
        }
    }
    
    //MARK: Equitable
    
    static func == (lhs: AstroDate, rhs: AstroDate) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month
            && lhs.day == rhs.day
    }
    
    //MARK: Conversion to Date
    
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        let date = formatter.date(from: "\(self.year)/\(self.month)/\(self.day) \(self.hour):\(self.minute):\(self.second)")!
        return(date)
    }
    
    //MARK: Date functions
    
    func isLeapYear() -> Bool {
        return ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))
    }
    
    func dayNumber() -> Int {
        
        var dn = 0.0
        
        if (month > 2) {
            var m = Int(Double(month + 1) * 30.6)
            if (isLeapYear()) {
                m -= 62
            } else {
                m -= 63
            }
            dn = Double(m)
        } else {
            var m = Double(month - 1)
            if (self.isLeapYear()) {
                m *= 62
            } else {
                m *= 63
            }
            dn = floor(m / 2.0)
        }
        
        return(Int(dn) + day)
    }
    
    func julianDayNumber() -> Double {

        
        let date = AstroDate(month: 10, day: 15, year: 1582)


        if (month == 1 || month == 2) {
            year -= 1
            month += 12
        }
        
        let a = Int(Double(year) / 100.0)
        var b = 0
        if (self > date) {
           b = 2 - a + Int(a / 4)
        }

        let c = Int(365.25 * Double(year))
        let d = Int(30.6001 * (Double(month) + 1.0))
        let jd = Double(b) + Double(c) + Double(d) + Double(day) + (Double(hour) / 24.0) + 1720994.5
        return(jd)
    }
    
    func dayOfWeek() -> String {
        let jd = self.julianDayNumber()
        let a = (jd + 1.5) / 7.0
        let b = a.truncatingRemainder(dividingBy: 1) * 7.0
        let i = Int(b.rounded())
        return(["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][i])
    }
    
    func decimalTime() -> Double {
        var d = Double(second) / 60.0
        
        d += Double(minute)
        d /= 60.0
        d += Double(hour)
        return(d)
    }
    
    
    func gmtToGST() -> AstroDate {
        
        var d = Double(self.dayNumber())
        
        d *= 0.0657098
        

        let b = SwiftAstro().calculateConstB(date: self)
        
        let t0 = d - b
        
        let gmtDecimal = self.decimalTime() * 1.002738
        
        var t1 = t0 + gmtDecimal
        
        if (t1 > 24) {
            t1 -= 24.0
        } else if (t1 < 0) {
            t1 += 24.0
        }
        
        let result = SwiftAstro().decimalTimeToHMS(decimalTime: t1)
        let fractionalSeconds = result.2.rounded(toPlaces: 3)

        return(AstroDate(month: month, day: day, year: year, hour: result.0, minute: result.1, second: fractionalSeconds))
    }
    
        func gstToGMT() -> AstroDate {
          
    
            var d = Double(self.dayNumber())
            d *= 0.0657098
            let b = SwiftAstro().calculateConstB(date: self)
    
    
    
            var t0 = d - b
            if (t0 < 0) {
                t0 += 24
            }
    
            let gstDecimal = self.decimalTime()
    
            var t1 = gstDecimal - t0
            if (t1 < 0) {
                t1 += 24
            }
    
            t1 *= 0.997270
    
            let result = SwiftAstro().decimalTimeToHMS(decimalTime: t1)
    
    
            let fractionalSeconds = result.2.rounded(toPlaces: 3)
                
            return(AstroDate(month: month, day: day, year: year, hour: result.0, minute: result.1, second: fractionalSeconds))
        }
    
}
