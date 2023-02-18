//
//  Sqlite3.swift
//  Cryato
//
//  Created by John Melody Me on 18/02/2023.
//

import Foundation

#if canImport(SQLite)
import SQLite
#endif

class DatabaseManager {
    private var FILE_NAME :String = "Records.sqlite3"
    private var database :Connection!
    private var RECORDS :Table!
    private var id :Expression<Int64>!
    private var dateTime :Expression<String>!
    private var unitPurchased :Expression<Int64>!
    private var originalPrice :Expression<Double>!
    private var sellingPrice :Expression<Double>!
    private var cryptoCurrencyName :Expression<String>!
    private var earned :Expression<Double>!
    
    public init() {
        do {
            let path :String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            self.database = try Connection("\(path)/\(self.FILE_NAME)")
            self.RECORDS = Table("Records")
            self.id = Expression<Int64>("id")
            self.dateTime = Expression<String>("dateTime")
            self.unitPurchased = Expression<Int64>("unitPurchased")
            self.originalPrice = Expression<Double>("originalPrice")
            self.sellingPrice = Expression<Double>("sellingPrice")
            self.cryptoCurrencyName = Expression<String>("cryptoCurrencyName")
            self.earned = Expression<Double>("earned")
            
            if !UserDefaults.standard.bool(forKey: "is_db_created") {
                try! self.database.run(RECORDS.create { (table) in
                    table.column(self.id, primaryKey: true)
                    table.column(self.dateTime)
                    table.column(self.unitPurchased)
                    table.column(self.originalPrice)
                    table.column(self.sellingPrice)
                    table.column(self.cryptoCurrencyName)
                    table.column(self.earned)
                })
                
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
        } catch {
            NSLog(error.localizedDescription)
        }
    }
    
    public func addRecord(
        unitPurchased :Int64?,
        originalPrice :Double?,
        sellingPrice :Double?,
        crypto :String?,
        earned :Double?
    ) throws -> Void {
        try! self.database.run(
            self.RECORDS.insert(
                self.dateTime <- try! Helper.currentDate(),
                self.unitPurchased <- unitPurchased!,
                self.originalPrice <- originalPrice!,
                self.sellingPrice <- sellingPrice!,
                self.cryptoCurrencyName <- crypto!,
                self.earned <- earned!
            )
        )
        
        NSLog("Saved TO Database")
    }
    
    public func getRecords() throws -> [DBTransRecords] {
        var dbTransRecords :[DBTransRecords] = [DBTransRecords]()
        
        do {
            for record in try! self.database.prepare(self.RECORDS) {
                var dbRecord :DBTransRecords = DBTransRecords()
                
                dbRecord.id = record[id]
                dbRecord.originalPrice = record[originalPrice]
                dbRecord.sellingPrice = record[sellingPrice]
                dbRecord.unitPurchased = record[unitPurchased]
                dbRecord.earned = record[earned]
                dbRecord.cryptoCurrencyName = record[cryptoCurrencyName]
                dbRecord.dateTime = record[dateTime]
                
                dbTransRecords.append(dbRecord)
            }
        }
        
        return dbTransRecords
    }
}
