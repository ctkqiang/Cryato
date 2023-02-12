//
//  String.swift
//  Cryato
//
//  Created by John Melody Me on 11/02/2023.
//

import Foundation

extension String {
    public func isContainSpecialChars() throws -> Bool {
        let letters :CharacterSet = CharacterSet.punctuationCharacters
        let range = self.rangeOfCharacter(from: letters)
        
        return range != nil ? true : false
    }
    
    
}
