//
//  SharedPreferences.swift
//  Cryato
//
//  Created by John Melody Me on 09/02/2023.
//

import Foundation


public struct SharedPreferences {
    public var key :String
    public var type :SharedPreferenceType
    public var properties :String?
    
    public init(_ key :String, _ properties :String?, _ type :SharedPreferenceType) throws {
        self.key = key
        self.type = type
        self.properties = properties
        
        if type == SharedPreferenceType.SET {
            try SharedPreferences.setData(value: self.properties ?? "", key: self.key)
        }
    }

    public static func setData(value: Any, key: String) throws -> Void {
        var userDefault = UserDefaults.standard
        
        userDefault.set(value, forKey: key)
        userDefault.synchronize()
    }
    
    public static func getData(key :String) throws -> String {
        var userDefault = UserDefaults.standard
        
        if userDefault.object(forKey: key) == nil {
            return ""
        }
        
        return userDefault.string(forKey: key)!
    }
}
