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
    private var COIN_GECKO = "https://api.coingecko.com/api/v3/ping"
    
    public static func ping(completion: @escaping (CoinGeckoStatus) -> ()) throws -> Void {
        let url :URL = URL(string: CoinGecko().COIN_GECKO)!
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
                
                let model = try! JSONDecoder().decode(CoinGeckoStatus.self, from: data)
                
                DispatchQueue.main.async {
                    completion(model)
                }
            }.resume()
        }
    }
    
    public func getSimplePrice<T : Codable>(
        ticker :String = "TETHER",
        currencry :String,
        completion: @escaping (T) -> ()
    ) throws -> Void {
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
        }
}
