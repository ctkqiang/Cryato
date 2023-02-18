//
//  DBTransactionsRecords.swift
//  Cryato
//
//  Created by John Melody Me on 18/02/2023.
//

import Foundation

struct DBTransRecords : Identifiable {
    public var id :Int64 = 0
    public var dateTime :String = ""
    public var unitPurchased :Int64 = 0
    public var originalPrice :Double = 0.0
    public var sellingPrice :Double = 0.0
    public var cryptoCurrencyName :String = ""
    public var earned :Double = 0.0
}
