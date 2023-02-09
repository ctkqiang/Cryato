//
//  TransactionsHelper.swift
//  Cryato
//
//  Created by John Melody Me on 10/02/2023.
//

import Foundation

class TransactionsHelper : ObservableObject {
    public static func loadTransactions(WalletID :String, completion: @escaping (Transactions) -> ()) {
        guard let url = URL(string: "https://api.trongrid.io/v1/accounts/\(WalletID)/transactions/trc20") else {
            print("The url is not working...")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let result = try! JSONDecoder().decode(Transactions.self, from: data!)
            
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}
