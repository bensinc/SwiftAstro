//
//  File.swift
//  
//
//  Created by Ben Sinclair on 1/14/21.
//

import Foundation

class AstroDate : Comparable, Equatable {
    var month: Int
    var day: Int
    var year: Int
    
    var hour: Int
    var minute: Int
    var second: Double
    
    
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
    
}
