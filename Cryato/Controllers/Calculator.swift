//
//  Calculator.swift
//  Cryato
//
//  Created by John Melody Me on 01/02/2023.
//

import Foundation

class Calculator {
    
    public init() { }
    
    public func calculateProfits(_ originalPrice :Double, _ sellingPrice :Double) throws -> String {
        return String(sellingPrice - originalPrice)
    }
}
