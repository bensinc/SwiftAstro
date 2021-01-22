//
//  File.swift
//  
//
//  Created by Ben Sinclair on 1/14/21.
//

import Foundation


///  🗓 Represents a date and time with no time zone or other context.
///  🕒 Provides various functions for converting between time systems and doing other calculations.
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
    
    /**
         Initializes a new AstroDate with the specified date and time

         - Returns: A new AstroDate object
     */
    init(month: Int, day: Int, year: Int, hour: Int, minute: Int, second: Double) {
        self.month = month
        self.day = day
        self.year = year
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
    /**
         Initializes a new AstroDate with the specified date.

         

         - Returns: A new AstroDate object with the specified date. The time values will be set to 0.
     */
    init(month: Int, day: Int, year: Int) {
        self.month = month
        self.day = day
        self.year = year
        self.hour = 0
        self.minute = 0
        self.second = 0.0
    }

    /**
         Initializes a new AstroDate with the specified date and hour.

         

         - Returns: A new AstroDate object with the specified date. The minute and second values will be set to 0.
     */
    init(month: Int, day: Int, year: Int, hour: Int) {
        self.month = month
        self.day = day
        self.year = year
        self.hour = hour
        self.minute = 0
        self.second = 0.0
    }
    
    /**
         Initializes a new AstroDate with the specified time.

         

         - Returns: A new AstroDate object with the specified time. The date will be set to 0
     */
    init(hour: Int, minute: Int, second: Double) {
        self.month = 0
        self.day = 0
        self.year = 0
        
        self.hour = hour
        self.minute = minute
        self.second = second
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
    
    //MARK: Equatable
    
    static func == (lhs: AstroDate, rhs: AstroDate) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month
            && lhs.day == rhs.day  && lhs.hour == rhs.hour && lhs.minute == rhs.minute && lhs.second == rhs.second
    }
    
    //MARK: Conversion to Date
    
    /**
     Converts AstroDate to a Swift Date.

     - Returns: A Date

     */
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let date = formatter.date(from: "\(self.year)/\(self.month)/\(self.day) \(self.hour):\(self.minute):\(self.second)")!
        return(date)
    }
    
    
    //MARK: Date utilities
    
    /**
     Utility function to return the integer and remainder of a division
     
     - Parameters:
          - a: The dividend
          - b: The divisor
        
     - Returns: A tuple containing the integer portion (0) and the remainder (1)

     */
    static func divideWithRemainder(a: Int, b: Int) -> (Int, Int) {
        return(Int(floor(Double(a) / Double(b))), a % b)
    }
    
    /**
     Calculates the date of Easter
        
     - Returns: An AstroDate set to the date of Easter

     */
    static func dateOfEaster(year: Int) -> AstroDate {
        
        // Divide the year by 19
        let a = divideWithRemainder(a: year, b: 19).1
        
        // Divide the year by 100
        var r = divideWithRemainder(a: year, b: 100)
        let b = r.0
        let c = r.1

        // Divide b by 4
        r = divideWithRemainder(a: b, b: 4)
        let d = r.0
        let e = r.1
       
        // Divide (b + 8) by 25
        let f = divideWithRemainder(a: (b + 8), b: 25).0
        
        // Divide (b - f + 1) by 3
        let g = divideWithRemainder(a: (b - f + 1), b: 3).0
        
        // Divide (19a + b - d - g + 15) by 30
        let h = divideWithRemainder(a: ((19 * a) + b - d - g + 15), b: 30).1
        
        // Divide c by 4
        r = divideWithRemainder(a: c, b: 4)
        let i = r.0
        let k = r.1
        
        // Divide (32 + 2e + 2i - h - k) by 7
        let l = divideWithRemainder(a: 32 + (2 * e) + (2 * i) - h - k, b: 7).1
        
        // Divide (a + 11h + 22l) by 451
        let m = divideWithRemainder(a: a + (11 * h) + (22 * l), b: 451).0
        
        // Divid (h + l - 7m + 114) by 31
        r = divideWithRemainder(a: h + l - (7 * m) + 114, b: 31)
        let n = r.0
        let p = r.1
        
        let month = n
        let day = p + 1
        
        return(AstroDate(month: month, day: day, year: year))
    }
    
    /**
     Converts a Julian date to Gregorian date
     
     - Parameters:
          - jd: a Julian date
        
     - Returns: AstroDate

     */
    static func julianDayToDate(jd: Double) -> AstroDate {
        let julianDate = jd + 0.5
        
        let i = Int(julianDate)
        let f = julianDate - Double(i)
        
        var a = i
        
        if (i > 2299160) {
            a = Int((Double(i) - 1867216.25) / 36524.25)
        }
        
        let b = i + 1 + a - Int(Double(a) / 4.0)
        
        let c = b + 1524
        
        let d = Int((Double(c) - 122.1) / 365.25)
        
        let e = Int(365.25 * Double(d))
        
        let g = Int(Double(c - e) / 30.6001)
        
        let day = Double(c) - Double(e) + f - Double(Int(30.6001 * Double(g)))
        
        var month = g - 1
        if (Double(g) > 13.5) {
            month = g - 13
        }
        
        var year = d - 4716
        if (Double(month) < 2.5) {
            year = d - 4715
        }
        
        let hour = Int(24.0 * day.truncatingRemainder(dividingBy: 1))
        
        
    
        return(AstroDate(month: month, day: Int(day), year: year, hour: hour))
    }
    
    static func decimalTimeToHMS(decimalTime: Double) -> (hour: Int, minute: Int, second: Double) {
        let f = decimalTime.truncatingRemainder(dividingBy: 1) * 60.0
        let minutes = Int(f)
        let seconds = f.truncatingRemainder(dividingBy: 1) * 60.0
        return(Int(decimalTime), minutes, seconds)
    }
    
    static func decimalTimeToDate(decimalTime: Double) -> AstroDate {
                   
        let f = decimalTime.truncatingRemainder(dividingBy: 1) * 60.0
        let minutes = Int(f)
        let seconds = f.truncatingRemainder(dividingBy: 1) * 60
        
        return(AstroDate(month: 0, day: 0, year: 0, hour: Int(decimalTime), minute: minutes, second: seconds))
        
    }
    
    //MARK: Date functions
    
    func calculateConstB(date: AstroDate) -> Double {
                            
        let d = AstroDate(month: 12, day: 31, year: date.year - 1, hour: 0)
        let jd = d.julianDayNumber()
        
        let s = jd - 2415020.0
        let t = s / 36525.0
        let r = 6.6460656 + (2400.051262 * t) + (0.00002581 * pow(t, 2))
        let u = r - (24 * Double(date.year - 1900))
        let b = 24 - u
        return(b)
    }
    
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
        
        
        let b = calculateConstB(date: self)
        
        let t0 = d - b
        
        let gmtDecimal = self.decimalTime() * 1.002738
        
        var t1 = t0 + gmtDecimal
        
        if (t1 > 24) {
            t1 -= 24.0
        } else if (t1 < 0) {
            t1 += 24.0
        }
        
        let result = AstroDate.decimalTimeToHMS(decimalTime: t1)
        let fractionalSeconds = result.2.rounded(toPlaces: 3)
        
        return(AstroDate(month: month, day: day, year: year, hour: result.0, minute: result.1, second: fractionalSeconds))
    }
    
    func gstToGMT() -> AstroDate {
        
        
        var d = Double(self.dayNumber())
        d *= 0.0657098
        let b = calculateConstB(date: self)
        
        
        
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
        
        let result = AstroDate.decimalTimeToHMS(decimalTime: t1)
        
        
        let fractionalSeconds = result.2.rounded(toPlaces: 3)
        
        return(AstroDate(month: month, day: day, year: year, hour: result.0, minute: result.1, second: fractionalSeconds))
    }
    
    func gstToLST(toLon: Double) -> AstroDate {
        let decimalGST = self.decimalTime()
        let timeDifference = toLon / 15.0
        var lst = decimalGST + timeDifference
        if (lst > 24) {
            lst -= 24
        }
        if (lst < 0) {
            lst += 24
        }
        return(AstroDate.decimalTimeToDate(decimalTime: lst))
    }
    
    func lstToGST(fromLon: Double) -> AstroDate {
        let decimalHours = self.decimalTime()
        let timeDifference = fromLon / 15.0 * -1
        
        var gst = decimalHours + timeDifference
        
        if (gst > 24) {
            gst -= 24
        }
        if (gst < 0) {
            gst += 24
        }
        return(AstroDate.decimalTimeToDate(decimalTime: gst))
    }
    
}
