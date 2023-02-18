//
//  File.swift
//  Cryato
//
//  Created by John Melody Me on 18/02/2023.
//

import Foundation

struct CoinGecko {
    private var BASE_URL :String = "https://api.coingecko.com/api/v3/"
    private var SIMPLE_PRICE_ENDPOINT :String = "simple/price"
    
    public func getSimplePrice(ticker :String, currencry :String) throws -> [String] {
        var price :[String] = [String]()
        let url :URL = URL(string: "\(self.BASE_URL)\(self.SIMPLE_PRICE_ENDPOINT)?ids=\(ticker)&vs_currencies=\(currencry)")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    NSLog("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    NSLog("[CoinGecko] returned \(httpStatus.statusCode) : \(String(describing: response))")
                }
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(String(describing: responseString))")
                    
                    let jsonData = responseString.data(using: .utf8)!
                    
                    
                    // @TODO do adjustment
                    
                }
            }
            
            task.resume()
        }
        
        return price
    }
}
