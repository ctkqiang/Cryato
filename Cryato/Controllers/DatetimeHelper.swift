//
//  DatetimeHelper.swift
//  Cryato
//
//  Created by John Melody Me on 11/02/2023.
//

import Foundation


struct DatetTime {
    public static func getCurrentUNIXTimeStamp() throws -> String {
        return NSDate().timeIntervalSince1970.rounded(.towardZero).clean
    }
}
