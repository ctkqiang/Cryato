//
//  PreferenceView.swift
//  Cryato
//
//  Created by John Melody Me on 31/01/2023.
//

import SwiftUI

#if canImport(Toast)
import Toast
#endif

#if canImport(AlertToast)
import AlertToast
#endif


struct PreferenceView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.openURL) private var openURL
    
    @State private var isPresentingAlert: Bool = false
    @State private var isPresentingDonation: Bool = false
    @State private var isShowingWebView: Bool = false
    @State private var tronSearchTextFieldIsDisabled :Bool = false
    @State private var bybitSearchTextFieldIsDisabled :Bool = false
    @State private var showWechatContact :Bool = false
    @State private var selectedCurrency :String = ""
    @State private var selectedItem: String = ""
    @State private var tronScanApi: String = ""
    @State private var bybitApi: String = ""
    @State private var binanceApi: String = ""
    @State private var kucoinApi: String = ""
    @State private var huobiApi: String = ""
    @State private var bitgetApi: String = ""
    
    private var tronApiKey :String = ""
    private var wechatContact :String = "weixin://dl/chat?johnmelodyme"
    private var wiseUrl: String = "https://github.com/johnmelodyme/Cryato"
    private var preferenceItems: [String] = [
        "Who created this app?",
        "Version",
    ]
    private var currencies :[String] = SupportableCurrencies.currencies
    
    private func openUrl(url: String) {
        if self.selectedItem == self.preferenceItems[1] {
            if let url = URL(string: self.wiseUrl) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    public init() {
        if let tronDefaultAPI = Bundle.main.infoDictionary?["TRON_SEARCH_API"] as? String {
            if SharedPreferences.getData(key: "tronapi") != "nil" {
                self.tronScanApi = SharedPreferences.getData(key: "tronapi")
            }
            
            self._tronScanApi = State(wrappedValue: tronDefaultAPI)
            
            if !self.tronScanApi.isEmpty {
                self.tronSearchTextFieldIsDisabled = true
            }
        }
        
#if DEBUG
        
        if let bybitApiKey = Bundle.main.infoDictionary?["BYBIT_API_KEY"] as? String {
            self.bybitApi = bybitApiKey
            self.bybitSearchTextFieldIsDisabled = true
            self._bybitApi = State(wrappedValue: bybitApiKey)
        }
        
#else
        
        if SharedPreferences.getData(key: "bybitApiKey") as String == nil {
            SharedPreferences.setData(key: "bybitApiKey", value: self.bybitApi)
            self.bybitSearchTextFieldIsDisabled = true
        }
        
        if let bybitApiKeyLocal = SharedPreferences.getData(key: "bybitApiKey") as String {
            self.bybitApi = bybitApiKeyLocal
            self.bybitSearchTextFieldIsDisabled = true
            
            self._bybitApi = State(wrappedValue: bybitApiKeyLocal)
        }
        
#endif
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("App Setting")) {
                        Picker("Currency", selection: self.$selectedCurrency) {
                            ForEach(self.currencies, id: \.self) {
                                Text($0)
                            }
                        }
                        .onChange(of: self.selectedCurrency) { currency in
                            NSLog("User selected \(currency)")
                            
                            try! DatabaseManager.read(key: "currency") { selected in
                                if selected.isEmpty {
                                    try! DatabaseManager.write(key: "currency", value: currency)
                                    
                                    NSLog("\(self.selectedCurrency) added to User Defaults")
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("API Integrations")) {
                        TextField(
                            (self.tronScanApi == "" ? "Tron Scan API" : self.tronScanApi),
                            text: self.$tronScanApi
                        )
                        .disabled(self.tronSearchTextFieldIsDisabled)
                        .font(Font.system(size: 12))
                        
                        TextField(
                            (self.bybitApi == "" ? "ByBit API" : self.bybitApi),
                            text: self.$bybitApi
                        )
                        .disabled(self.bybitSearchTextFieldIsDisabled)
                        .font(Font.system(size: 12))
                        
                        TextField(
                            "Binance API",
                            text: self.$binanceApi
                        )
                        .disabled(self.tronSearchTextFieldIsDisabled)
                        .font(Font.system(size: 12))
                        
                        TextField(
                            "KuCoin API",
                            text: self.$kucoinApi
                        )
                        .disabled(self.tronSearchTextFieldIsDisabled)
                        .font(Font.system(size: 12))
                        
                        TextField(
                            "BitGet API",
                            text: self.$bitgetApi
                        )
                        .disabled(self.tronSearchTextFieldIsDisabled)
                        .font(Font.system(size: 12))
                        
                    }
                    
                    Section(header: Text("About")) {
                        List {
                            ForEach(self.preferenceItems, id: \.self) { items in
                                Button {
                                    self.isPresentingAlert = true
                                    self.selectedItem = items
                                } label: {
                                    Text(items).foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                                }.alert(
                                    isPresented: self.$isPresentingAlert,
                                    content: {
                                        
                                        if self.selectedItem == self.preferenceItems[1] {
                                            return Alert(
                                                title: Text(self.selectedItem),
                                                message: Text(
                                                    "This app is running on Version 1.0.0"
                                                ),
                                                dismissButton: .default(Text("Okay"))
                                            )
                                        }
                                        
                                        return Alert(
                                            title: Text(self.selectedItem),
                                            message: Text(
                                                "This application is developed by \nJohn Melody Me"
                                            ),
                                            dismissButton: .default(Text("Okay"))
                                        )
                                    }
                                ).fixedSize()
                            }
                            
                            Button(
                                "Support this application",
                                action: {
                                    self.isPresentingDonation = true
                                }
                            )
                            .foregroundColor(
                                self.colorScheme == .dark ? Color.white : Color.black
                            ).alert(
                                isPresented: self.$isPresentingDonation,
                                content: {
                                    return Alert(
                                        title: Text("Disclaimer"),
                                        message: Text(
                                            "Visit \n\(wiseUrl) for more."
                                        )
                                        .font(.system(size: 6)),
                                        primaryButton: .default(Text("Ok")),
                                        secondaryButton: .cancel()
                                    )
                                }
                            )
                            
                            Button(
                                "Contact Developer",
                                action: {
                                    self.showWechatContact = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                        try! Helper.openUrl(url: self.wechatContact) { status in
                                            NSLog(String(describing: status))
                                        }
                                    }
                                }
                            ).foregroundColor(
                                self.colorScheme == .dark ? Color.white : Color.black
                            )
                        }
                    }
                    
                }
                .toast(isPresenting: self.$showWechatContact, alert: {
                    AlertToast(
                        type: .complete(.green),
                        title: "Contact Developer",
                        subTitle: "Wechat: @johnmelodyme"
                    )
                })
            }
        }
        
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
