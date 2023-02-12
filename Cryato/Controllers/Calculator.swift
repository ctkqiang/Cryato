//
//  Calculator.swift
//  Cryato
//
//  Created by John Melody Me on 01/02/2023.
//

import Foundation

class Calculator {
    public init() { }
    
    public func calculateProfits(originalPrice :Double, sellingPrice :Double) throws -> String {
        return String(sellingPrice - originalPrice)
    }
    
    public static func isPluralSell(_ unit :Double, _ profits :Double?) throws -> [String] {
        return (unit > 1 && profits! > 2) ? ["units are sold", "profits"] : ["unit is sold", "profit"]
    }
    
    public static func profit(original :String, selling :String , unit :String) throws -> [String] {
        let originalPrice :Double = Double(original) ?? 0
        let sellingPrice :Double = Double(selling) ?? 0
        let unitBought :Double = Double(unit) ?? 0
        let value :Double = (sellingPrice - originalPrice) * unitBought
        
        return [
            "When \(unitBought.clean) \(unitBought > 1 ? "units are sold" : "unit is sold"), you \(try! self.isPNL(value: value).rawValue) $\(value.roundTwoDigits.onlyNumbers(text: String(value)).round(to: 2))",
            (value < 0) ? PNL.LOST.rawValue : PNL.PROFIT.rawValue
        ]
    }
    
    public static func isPNL(value :Double) throws -> PNL {
        return (value < 0) ? PNL.LOST : PNL.PROFIT
    }
}
