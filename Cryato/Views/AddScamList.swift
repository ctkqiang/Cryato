//
//  AddScamList.swift
//  Cryato
//
//  Created by John Melody Me on 15/02/2023.
//

import SwiftUI

#if canImport(AlertToast)
import AlertToast
#endif

struct AddScamList: View {
    @State private var walletID: String = ""
    @State private var paymentMethod: String = ""
    @State private var currency: String = ""
    @State private var platform: String = ""
    @State private var name: String = ""
    @State private var technique: String = ""
    
    private var WalletIdPlaceholder :String = "What's the scammer's Wallet Address?"
    private var PaymentMethodPlaceholder :String = "What's the payment method?"
    private var CurrencyPlaceholder :String = "What's the Currency?"
    private var PlatformPlaceholder :String = "What's the platform the scammer used?"
    private var NamePlaceholder :String = "What's your name?"
    private var TechniquePlaceholder :String = "What's the technique the scammer used?"
    
    public var body: some View {
        TextField(self.WalletIdPlaceholder, text: self.$walletID)
            .textFieldStyle(.roundedBorder)
            .font(Font.system(size: 15))
            .padding(5)
        
        TextField(self.PaymentMethodPlaceholder, text: self.$paymentMethod)
            .textFieldStyle(.roundedBorder)
            .font(Font.system(size: 15))
            .padding(5)
        
        TextField(self.CurrencyPlaceholder, text: self.$currency)
            .textFieldStyle(.roundedBorder)
            .font(Font.system(size: 15))
            .padding(5)
        
        TextField(self.PlatformPlaceholder, text: self.$platform)
            .textFieldStyle(.roundedBorder)
            .font(Font.system(size: 15))
            .padding(5)
        
        TextField(self.NamePlaceholder, text: self.$name)
            .textFieldStyle(.roundedBorder)
            .font(Font.system(size: 15))
            .padding(5)
        
        TextField(self.TechniquePlaceholder, text: self.$technique)
            .textFieldStyle(.roundedBorder)
            .font(Font.system(size: 15))
            .padding(5)
    }
}

struct AddScamList_Previews: PreviewProvider {
    static var previews: some View {
        AddScamList()
    }
}
