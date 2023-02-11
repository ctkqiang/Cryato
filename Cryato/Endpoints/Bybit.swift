//
//  Bybit.swift
//  Cryato
//
//  Created by John Melody Me on 11/02/2023.
//

import Foundation

struct Bybit {
    #if DEBUG
    
    public static var apiEndpoints :String = "https://api-testnet.bybit.com"

    #else
    
    public static var apiEndpoints :String = "https://api.bybit.com"
    
    #endif
    
    /** Get Wallet Balance */
    public static var getWalletBalance :String = "/v5/account/wallet-balance"
    
    /** Get All Coin Balance in the Wallet or Account */
    public static var getAllCoinBalance :String = "/v5/asset/transfer/query-account-coins-balance"
    
    /** Get All Specific Coin Balance in the Account */
    public static var getSingleCoinBalance :String = "/v5/asset/transfer/query-account-coin-balance"
    
    /** Get All Assets in SPOT fint the Account */
    public static var getSpotAssets :String = "/v5/asset/transfer/query-asset-info"
}
