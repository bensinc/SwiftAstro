//
//  File.swift
//  
//
//  Created by Ben Sinclair on 1/13/21.
//

import Foundation

extension Date {
    
    func isLeapYear() -> Bool {
        let year = Calendar.current.component(.year, from: self)
        return ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))
    }
    
    func dayNumber() -> Int {
        let month = Calendar.current.component(.month, from: self)
        
        var day = 0.0
        
        if (month > 2) {
            var m = Int(Double(month + 1) * 30.6)
            if (isLeapYear()) {
                m -= 62
            } else {
                m -= 63
            }
            day = Double(m)            
        } else {
            var m = Double(month - 1)
            if (self.isLeapYear()) {
                m *= 62
            } else {
                m *= 63
            }
            day = floor(m / 2.0)
        }
        
        return(Int(day) + Calendar.current.component(.day, from: self))
    }
    
    func julianDayNumber() -> Double {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = formatter.date(from: "1582/10/15")!
        
        var year = Calendar.current.component(.year, from: self)
        var month = Calendar.current.component(.month, from: self)
        let day = Calendar.current.component(.day, from: self)
        let hour = Calendar.current.component(.hour, from: self)

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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return(dateFormatter.string(from: self))
    }
    
    func decimalTime() -> Double {
        
        let hour = Calendar.current.component(.hour, from: self)
        let minute = Calendar.current.component(.minute, from: self)
        let second = Calendar.current.component(.second, from: self)
        
        var d = Double(second) / 60.0
        
        d += Double(minute)
        d /= 60.0
        d += Double(hour)
        return(d)
    }
    

    
    func gmtToGST() -> Date {
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        let day = Calendar.current.component(.day, from: self)
        
        

        
        var d = Double(self.dayNumber())
        
        d *= 0.0657098
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        
//        let jd = date.julianDayNumber()
//
//        let s = jd - 2415020.0
//        let t = s / 36525.0
//        let r = 6.6460656 + (2400.051262 * t) + (0.00002581 * pow(t, 2))
//        let u = r - (24 * Double(year - 1900))
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
        
        let fs = "\(year)/\(month)/\(day) \(result.0):\(result.1):\(fractionalSeconds)"
        let gstDate = formatter.date(from: fs)!
        return(gstDate)
    }
    
    func gstToGMT() -> Date {
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        let day = Calendar.current.component(.day, from: self)
        
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        
        let fractionalSeconds = result.2.rounded(toPlaces: 3)
        
        let fs = "\(year)/\(month)/\(day) \(result.0):\(result.1):\(fractionalSeconds)"
        let gmtDate = formatter.date(from: fs)!
        return(gmtDate)
    }
}
