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

#if canImport(LogToDiscord)
import LogToDiscord
#endif

struct AddScamList: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>
    
    @State private var walletID: String = ""
    @State private var paymentMethod: String = ""
    @State private var currency: String = ""
    @State private var platform: String = ""
    @State private var name: String = ""
    @State private var technique: String = ""
    @State private var showAlert :Bool = false
    
    private var WalletIdPlaceholder :String = "What's the scammer's Wallet Address or Username?"
    private var PaymentMethodPlaceholder :String = "What's the payment method?"
    private var CurrencyPlaceholder :String = "What's the Currency?"
    private var PlatformPlaceholder :String = "What's the platform the scammer used?"
    private var NamePlaceholder :String = "What's your name?"
    private var TechniquePlaceholder :String = "What's the technique the scammer used?"
    
    public var body: some View {
        NavigationView {
            VStack {
                Form {
                    VStack(alignment: .leading) {
                        Section(header: Text("")) {
                            TextField(self.WalletIdPlaceholder, text: self.$walletID)
                                .textFieldStyle(.roundedBorder)
                                .font(Font.system(size: 12))
                                .padding(5)
                            
                            TextField(self.PaymentMethodPlaceholder, text: self.$paymentMethod)
                                .textFieldStyle(.roundedBorder)
                                .font(Font.system(size: 12))
                                .padding(5)
                            
                            TextField(self.CurrencyPlaceholder, text: self.$currency)
                                .textFieldStyle(.roundedBorder)
                                .font(Font.system(size: 12))
                                .padding(5)
                            
                            TextField(self.PlatformPlaceholder, text: self.$platform)
                                .textFieldStyle(.roundedBorder)
                                .font(Font.system(size: 12))
                                .padding(5)
                            
                            TextField(self.NamePlaceholder, text: self.$name)
                                .textFieldStyle(.roundedBorder)
                                .font(Font.system(size: 12))
                                .padding(5)
                            
                            TextField(self.TechniquePlaceholder, text: self.$technique)
                                .textFieldStyle(.roundedBorder)
                                .font(Font.system(size: 12))
                                .padding(5)
                        }
                    }
                    .toast(isPresenting: self.$showAlert, alert: {
                        AlertToast(
                            type: .error(.red),
                            title: "Warning",
                            subTitle: "Please fill in all the required field!\n(except for \"walletid\")"
                        )
                    })
                }
                Button {
                    if self.currency.isEmpty ||
                        self.platform.isEmpty ||
                        self.name.isEmpty ||
                        self.technique.isEmpty {
                        self.showAlert = true
                    } else {
                        
                        let data :[String: String] = [
                            "Name" : self.name,
                            "WalletID" : self.walletID,
                            "PaymentMethod" : self.paymentMethod,
                            "Currency" : self.currency,
                            "Platform" : self.platform,
                            "Techniques" : self.technique
                        ]
                        
                        if let discordChannel = Bundle.main.infoDictionary?["DISCORD_WEBHOOK"] as? String {
                            try! LogToDiscord(
                                appName: "Cryato APP",
                                webhookUrl: "https://\(discordChannel)"
                            ).send(message: "\(data)", level: Level.Debug, delay: 0x1)
                            
                            self.mode.wrappedValue.dismiss()
                        }
                    }
                    
                    hideKeyboard()
                } label: {
                    Text("ADD TO DATABASE")
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            
            .frame(minWidth: 0, maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
            .tint(.blue)
            .frame(height: 60)
            .controlSize(.large)
            .padding()
            }
        }
    }
}

struct AddScamList_Previews: PreviewProvider {
    static var previews: some View {
        AddScamList()
    }
}
