//
//  Double.swift
//  Cryato
//
//  Created by John Melody Me on 01/02/2023.
//

import Foundation

extension Double {
    var roundThreeDigits: Double {
        return (self * 1000).rounded(.toNearestOrEven) / 1000
    }
    
    var roundTwoDigits: Double {
        return (self * 100).rounded(.toNearestOrEven) / 100
    }
    
}
