//
//  Double.swift
//  Cryato
//
//  Created by John Melody Me on 01/02/2023.
//

import Foundation

extension Double {
    public var roundThreeDigits: Double {
        return (self * 1000).rounded(.toNearestOrEven) / 1000
    }
    
    public var roundTwoDigits: Double {
        return (self * 100).rounded(.toNearestOrEven) / 100
    }
    
    public var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    public func onlyNumbers(text: String) -> Double {
        let okayChars = Set("1234567890.")
        return Double(text.filter {okayChars.contains($0) })!
    }
    
    public func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
