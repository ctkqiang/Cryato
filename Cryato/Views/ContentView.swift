//
//  ContentView.swift
//  Cryato
//
//  Created by John Melody Me on 31/01/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var selectedId :Int = 0x0
    @State private var isConnected :Bool = true
    @State private var options :[String] = ["Sell", "Buy"]
    @State private var isGeckoAvailable :Bool = false
    
    private var navigationTitle :String = "Cryato"
    
    public var body: some View {
        NavigationView {
            VStack {
                TabView {
                    VStack {
                        Picker(selection: $selectedId, label: Text("")) {
                            Text(options[0]).tag(0x0).font(Font.system(size: 12))
                            Text(options[1]).tag(0x1).font(Font.system(size: 12))
                        }.pickerStyle(.segmented).listRowSeparator(
                            .hidden, edges: [.top]
                        ).padding()
                        .background(Color(UIColor.systemGroupedBackground))
                        
                        if self.selectedId == 0x0 {
                            SellView()
                        } else {
                            BuyView()
                        }
                    }.tabItem {
                        Image(systemName: "number")
                        Text("Calculator")
                    }.background(Color(UIColor.systemGroupedBackground))
                    
                    ScannerView().tabItem {
                        Image(systemName: "dot.radiowaves.left.and.right")
                        Text("Scanner")
                    }
                    
                    RecordsView().tabItem {
                        Image(systemName: "note.text.badge.plus")
                        Text("Record")
                    }
                    
                    ScamView().tabItem {
                        Image(systemName: "exclamationmark.triangle.fill")
                        Text("Scams")
                    }
                    
                    AssetsView().tabItem {
                        Image(systemName: "wallet.pass.fill")
                        Text("Assets")
                    }
                }.tint(self.colorScheme == .dark ? Color.white : Color.black)
            }
            .scrollDismissesKeyboard(.interactively)
            .background(Color(UIColor.systemGroupedBackground))
            .refreshable {}
            .onAppear {
                if try! Helper().status() != NetworkStatus.CONNECTED {
                    self.isConnected = false
                }
                
                try! CoinGecko.ping() { result in

                    if result.gecko_says.contains("(V3) To the Moon!") {
                        self.isGeckoAvailable = true
                    }
                }
            }
        }.background(Color(UIColor.systemGroupedBackground))
    }
}

struct ContentView_Previews: PreviewProvider {
    public static var previews: some View {
        ContentView().environment(\.locale, .init(identifier: "zh"))
    }
}
