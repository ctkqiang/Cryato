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
    @State private var options :[String] = ["Sell", "Buy"]
    
    private var navigationTitle :String = "Cryato"

    
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    VStack {
                        Picker(selection: $selectedId, label: Text("")) {
                            Text(options[0]).tag(0x0)
                            Text(options[1]).tag(0x1)
                        }.pickerStyle(SegmentedPickerStyle()).listRowSeparator(
                            .hidden, edges: [.top]
                        ).padding()
                        
                        if self.selectedId == 0x0 {
                            SellView()
                        } else {
                            BuyView()
                        }
                    }.tabItem {
                        Image(systemName: "number")
                        Text("Calculator")
                    }
                    
                    ScannerView().tabItem {
                        Image(systemName: "dot.radiowaves.left.and.right")
                        Text("Scanner")
                    }
                    
                    RecordsView().tabItem {
                        Image(systemName: "note.text.badge.plus")
                        Text("Record")
                    }
                    
                    AssetsView().tabItem {
                        Image(systemName: "wallet.pass.fill")
                        Text("Assets")
                    }
                }.tint(self.colorScheme == .dark ? Color.white : Color.black)
            }
            .scrollDismissesKeyboard(.interactively)
            .background(self.colorScheme == .dark ? .black : .white)
            .refreshable {}
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        /** Navigate to app preference page */
                        PreferenceView()
                    } label: {
                        Image(systemName: "gearshape").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                    }
                }
            }
        }.background(self.colorScheme == .dark ? .black : .white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
