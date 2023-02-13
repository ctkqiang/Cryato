//
//  Selector.swift
//  Cryato
//
//  Created by John Melody Me on 12/02/2023.
//

import Foundation

struct CryptoSelector {
    public static var cryptoCurrenciesChoices : [String] = [
        CryptoPair.USDT.rawValue,
        CryptoPair.USDC.rawValue,
        CryptoPair.USDD.rawValue,
        CryptoPair.BUSD.rawValue,
        CryptoPair.TUSD.rawValue,
        CryptoPair.BTC.rawValue,
        CryptoPair.BNB.rawValue,
        CryptoPair.ETH.rawValue,
        CryptoPair.XRP.rawValue
    ]
}
