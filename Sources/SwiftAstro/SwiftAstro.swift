import Foundation


class SwiftAstro {
    var text = "Hello, World!"
    
    func divideWithRemainder(a: Int, b: Int) -> (Int, Int) {
        let r = Double(a) / Double(b)
        let integerPart = Int(floor(r))
        let remainderPart = Int(round(r.truncatingRemainder(dividingBy: 1) * Double(b)))
        return(integerPart, remainderPart)
    }
    
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
}
