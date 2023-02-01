//
//  FormValidator.swift
//  Cryato
//
//  Created by John Melody Me on 01/02/2023.
//

import Foundation

struct FormValidator {
    public func validate(_ value :String) throws -> Bool {
        return value.isEmpty ? true : false;
    }
}
