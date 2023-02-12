//
//  Utilities.swift
//  Cryato
//
//  Created by John Melody Me on 13/02/2023.
//

import Foundation

struct Utilities {
    
    public func removeSpecialCharacter(word :String, specialChar :Set<Character>) throws -> String {
        let value = word.removeAll(where: { specialChar.contains($0) })
        
        
    }
}
