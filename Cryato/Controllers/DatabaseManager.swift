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
    
    public init() {
        do {
            let path :String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            self.database = try Connection("\(path)/\(self.FILE_NAME)")
            self.RECORDS = Table("Records")
            
            self.id = Expression<Int64>("id")
            self.dateTime = Expression<String>("dateTime")
            
        } catch {
            NSLog(error.localizedDescription)
        }
    }
}
