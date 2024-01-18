//
//  Double.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 20/12/2023.
//

import Foundation

extension Double{
    
    ///Converts a Double into a currency with 2 decimal places
    ///```
    /// Convert 1234.56 to $1,234.56
    ///```

    private var currenncy2Format: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
         return formatter
    }
    
    
    ///Converts a Double into a currency as a string with 2-6 decimal places
    ///```
    /// Convert 1234.56 to "$1,234.56"
    ///```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currenncy2Format.string(from: number) ?? "$0.00"
    }
    
    
    ///Converts a Double into a currency with 2-6 decimal places
    ///```
    /// Convert 1234.56 to $1,234.56
    /// Convert 1.23456 to $1.23456
    /// Convert 12.3456 to $12.3456
    ///```

    private var currenncyFormat: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
         return formatter
    }
    
    
    ///Converts a Double into a currency as a string with 2-6 decimal places
    ///```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 1.23456 to "$1.23456"
    /// Convert 12.3456 to "$12.3456"
    ///```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currenncyFormat.string(from: number) ?? "$0.00"
    }
    
    
    ///Converts a Double into a String representation
    ///```
    /// Convert 1.23456 to "1.23"
    ///```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    
    ///Converts a Double into a String representation with Percent symbol
    ///```
    /// Convert 1.23456 to "1.23%"
    ///```
    func asPercentString() -> String{
        return asNumberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
       /// ```
       /// Convert 12 to 12.00
       /// Convert 1234 to 1.23K
       /// Convert 123456 to 123.45K
       /// Convert 12345678 to 12.34M
       /// Convert 1234567890 to 1.23Bn
       /// Convert 123456789012 to 123.45Bn
       /// Convert 12345678901234 to 12.34Tr
       /// ```
       func formattedWithAbbreviations() -> String {
           let num = abs(Double(self))
           let sign = (self < 0) ? "-" : ""

           switch num {
           case 1_000_000_000_000...:
               let formatted = num / 1_000_000_000_000
               let stringFormatted = formatted.asNumberString()
               return "\(sign)\(stringFormatted)Tr"
           case 1_000_000_000...:
               let formatted = num / 1_000_000_000
               let stringFormatted = formatted.asNumberString()
               return "\(sign)\(stringFormatted)Bn"
           case 1_000_000...:
               let formatted = num / 1_000_000
               let stringFormatted = formatted.asNumberString()
               return "\(sign)\(stringFormatted)M"
           case 1_000...:
               let formatted = num / 1_000
               let stringFormatted = formatted.asNumberString()
               return "\(sign)\(stringFormatted)K"
           case 0...:
               return self.asNumberString()

           default:
               return "\(sign)\(self)"
           }
       }
}

