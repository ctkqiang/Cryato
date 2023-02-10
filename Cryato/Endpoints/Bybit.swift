//
//  Bybit.swift
//  Cryato
//
//  Created by John Melody Me on 11/02/2023.
//

import Foundation

struct Bybit {
    #if DEBUG
    
    public var apiEndpoints :String = "https://api-testnet.bybit.com"

    #else
    
    public var apiEndpoints :String = "https://api.bybit.com"
    
    #endif
    
    /** Get All Coin Balance in the Wallet or Account */
    public var getAllCoinBalance :String = "/v5/asset/transfer/query-account-coins-balance"
    
    /** Get All Specific Coin Balance in the Account */
    public var getSingleCoinBalance :String = "/v5/asset/transfer/query-account-coin-balance"
    
    /** Get All Assets in SPOT fint the Account */
    public var getSpotAssets :String = "/v5/asset/transfer/query-asset-info"
}
