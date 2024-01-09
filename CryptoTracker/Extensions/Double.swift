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
        formatter.usesGroupingSeparator = false
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
}

