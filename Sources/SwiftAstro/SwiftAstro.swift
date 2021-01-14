import Foundation


class SwiftAstro {
    
    func divideWithRemainder(a: Int, b: Int) -> (Int, Int) {
        return(Int(floor(Double(a) / Double(b))), a % b)
    }
    
    // Calculate the date of Easter
    func dateOfEaster(year: Int) -> Date {
        
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let easterDate = formatter.date(from: "\(year)/\(month)/\(day)")!
        return(easterDate)
    }
    
    func julianDayToDate(jd: Double) -> Date {
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
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        let date = formatter.date(from: "\(year)/\(month)/\(Int(day)) \(hour):00")!
        return(date)
    }
    
    func decimalTimeToHMS(decimalTime: Double) -> (hour: Int, minute: Int, second: Double) {
        let f = decimalTime.truncatingRemainder(dividingBy: 1) * 60.0
        let minutes = Int(f)
        let seconds = f.truncatingRemainder(dividingBy: 1) * 60.0
        return(Int(decimalTime), minutes, seconds)
    }
    
    func decimalTimeToDate(decimalTime: Double) -> Date {
                   
        let f = decimalTime.truncatingRemainder(dividingBy: 1) * 60.0
        let minutes = Int(f)
        let seconds = f.truncatingRemainder(dividingBy: 1) * 60
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"        
        return(formatter.date(from: "1980/01/01 \(Int(decimalTime)):\(minutes):\(Int(seconds))")!)
    }
    
    
    
}
