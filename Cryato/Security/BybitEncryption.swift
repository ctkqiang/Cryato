//
//  Bybit.swift
//  Cryato
//
//  Created by John Melody Me on 11/02/2023.
//

import Foundation

#if canImport(CryptoKit)
import CryptoKit
#endif

struct BybitEncryption {
    public func getSignature(parameters :String?, secret :String?) -> String? {
        let key = SymmetricKey(data: secret!.data(using: .utf8)!)
        let signature = HMAC<SHA256>.authenticationCode(for: Data(parameters!.utf8), using: key)
        
        // TODO
        
        return "\(signature)"
    }
}
