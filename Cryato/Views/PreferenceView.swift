//
//  PreferenceView.swift
//  Cryato
//
//  Created by John Melody Me on 31/01/2023.
//

import SwiftUI

struct PreferenceView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.openURL) private var openURL
    
    @State private var isPresentingAlert: Bool = false
    @State private var isPresentingDonation: Bool = false
    @State private var isShowingWebView: Bool = false
    @State private var tronSearchTextFieldIsDisabled :Bool = true
    @State private var selectedItem: String = ""
    @State private var tronScanApi: String = ""
    
    private var tronApiKey :String = ""
    private var wiseUrl: String = "https://github.com/johnmelodyme/Cryato"
    private var preferenceItems: [String] = [
        "Who created this app?",
        "Version",
    ]
    
    private func openUrl(url: String) {
        if self.selectedItem == self.preferenceItems[1] {
            if let url = URL(string: self.wiseUrl) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    init() {
        if let tronDefaultAPI = Bundle.main.infoDictionary?["TRON_SEARCH_API"] as? String {
            if SharedPreferences.getData(key: "tronapi") != "nil" {
                self.tronScanApi = SharedPreferences.getData(key: "tronapi")
            }
            
            self._tronScanApi = State(wrappedValue: tronDefaultAPI)
            
            if !self.tronScanApi.isEmpty {
                self.tronSearchTextFieldIsDisabled = true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("API Integrations")) {
                        HStack {
                            TextField(
                                (self.tronScanApi == "" ? "Tron Scan API" : self.tronScanApi),
                                text: self.$tronScanApi
                            )
                            .frame(height: 20)
                            .controlSize(.large)
                            .disabled(self.tronSearchTextFieldIsDisabled)
                            .font(Font.system(size: 12, design: .default))
                            
                            Button("EDIT") {
                                self.tronSearchTextFieldIsDisabled = false
                            }
                            .font(Font.system(size: 12, design: .default))
                            .foregroundColor(.red)
                        }
                    }
                    
                    Section(header: Text("About")) {
                        List {
                            ForEach(self.preferenceItems, id: \.self) {
                                items in
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
                                        ),
                                        primaryButton: .default(Text("Ok")),
                                        secondaryButton: .cancel()
                                    )
                                })
                        }
                    }
                    
                }
            }
        }
        
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
