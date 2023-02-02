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
    @State private var selectedItem: String = ""
    
    private var wiseUrl: String = "https://github.com/johnmelodyme/Cryato"
    private var preferenceItems: [String] = [
        "Who created this app?",
        "Version"
    ]
    
    private func openUrl(url :String) -> Void {
        if (self.selectedItem == self.preferenceItems[1]) {
            if let url = URL(string: self.wiseUrl) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            }
        }
    }
    
    var body: some View {
        VStack {
            Form {
                List {
                    ForEach(self.preferenceItems, id: \.self ) {
                        items in Button {
                            self.isPresentingAlert = true
                            self.selectedItem = items
                        } label: {
                            Text(items).foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                        }.alert(isPresented: self.$isPresentingAlert, content: {
                                                
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
                        }).fixedSize()
                    }
                    
                    Button("Support this application", action: {
                        self.isPresentingDonation = true
                    })
                    .foregroundColor(
                        self.colorScheme == .dark ? Color.white : Color.black
                    ).alert(isPresented: self.$isPresentingDonation, content: {
                        return Alert(
                            title: Text("Disclaimer"),
                            message: Text(
                                "You are about to open a donation url in the browser. Proceed?"
                            ),
                            primaryButton: .default(Text("Visit")) {
                                if let url = URL(string: self.wiseUrl) {
                                    openURL(url)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    })
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
