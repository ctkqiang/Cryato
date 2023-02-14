//
//  ScamListHandler.swift
//  Cryato
//
//  Created by John Melody Me on 14/02/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct ScamListHandler {
    public static func getScamList() throws -> Void {
        var responseData :Scam
        print("asdasd")
        
        if let url = URL(string: Scams.endpoints) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    print (response as Any)
                }
                
                if let error = error {
                    NSLog("\(error)")
                }
            
            }.resume()
        }
    }
}
