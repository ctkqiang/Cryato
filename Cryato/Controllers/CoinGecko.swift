//
//  File.swift
//  Cryato
//
//  Created by John Melody Me on 18/02/2023.
//

import Foundation

class CoinGecko : ObservableObject {
    private var BASE_URL :String = "https://api.coingecko.com/api/v3/"
    private var SIMPLE_PRICE_ENDPOINT :String = "simple/price"
    
    public func getSimplePrice<T : Codable>(
        ticker :String = "TETHER", currencry :String,
        completion: @escaping (T) -> ()) throws -> String {
            let url :URL = URL(string: "\(self.BASE_URL)\(self.SIMPLE_PRICE_ENDPOINT)?ids=\(ticker)&vs_currencies=\(currencry)")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        NSLog("error=\(String(describing: error))")
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                        NSLog("[CoinGecko] returned \(httpStatus.statusCode) : \(String(describing: response))")
                    }
                    
                    let model = try! JSONDecoder().decode(T.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(model)
                    }
                    
                }.resume()
            }
            
            return ""
        }
}
