//
//  PreferenceView.swift
//  Cryato
//
//  Created by John Melody Me on 31/01/2023.
//

import SwiftUI

struct PreferenceView: View {
    @Environment(\.openURL) private var openURL
    @State private var isPresentingAlert: Bool = false
    @State private var selectedItem: String = ""
    private var binanceUrl: String = "https://s.binance.com/8ER0kn3r"
    private var preferenceItems: [String] = ["Who created this app?", "Support this app", "Version"]
    
    func displayAlert() -> Alert {
        if (self.selectedItem == self.preferenceItems[1]) {
            self.openUrl(url: self.binanceUrl)
        }
        
        switch self.selectedItem {
        case self.preferenceItems[0]:
            return Alert(
                title: Text(self.selectedItem),
                message: Text(
                    "This application is developed by \nJohn Melody Me"
                ),
                dismissButton: .default(Text("Okay"))
            )
        case self.preferenceItems[2]:
            return Alert(
                title: Text(self.selectedItem),
                message: Text("You are running on Verions 1.0.0"),
                dismissButton: .default(Text("Okay"))
            )
        default:
            return Alert(title: Text(""), message: Text("Hi 🤗"))
        }
    }
    
    func openUrl(url :String) -> Void {
        if (self.selectedItem == self.preferenceItems[1]) {
            openURL(URL(string: url)!)
        }
    }
    
    var body: some View {
        List {
            ForEach(self.preferenceItems, id: \.self ) {
                items in Button {
                    self.isPresentingAlert = true
                    self.selectedItem = items
                } label: {
                    Text(items).foregroundColor(Color.black)
                }.alert(isPresented: self.$isPresentingAlert, content: {
                    self.displayAlert()
                }).fixedSize()
            }
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
