//
//  ScamListHandler.swift
//  Cryato
//
//  Created by John Melody Me on 14/02/2023.
//

import Foundation


class ScamListHandler : ObservableObject {
    public static func loadScamList(completion: @escaping ([Scam]) -> ()) {
        guard let url = URL(string: Scams.endpoints) else {
            NSLog("The url is not working...")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let result = try! JSONDecoder().decode([Scam].self, from: data!)
            
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}
