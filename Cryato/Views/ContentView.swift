//
//  ContentView.swift
//  Cryato
//
//  Created by John Melody Me on 31/01/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var selectedId = 0x0
    @State private var options = ["Sell", "Buy"]
    
    private var navigationTitle = "Cryato"
    
    var body: some View {
        NavigationView {
            VStack {
                Section(header: Text("").foregroundColor(
                    self.colorScheme == .dark ? Color.white : Color.black).bold().fixedSize()
                ) {
                    Picker(selection: $selectedId, label: Text("")) {
                        Text(options[0]).tag(0x0)
                        Text(options[1]).tag(0x1)
                    }.pickerStyle(SegmentedPickerStyle()).listRowSeparator(
                        .hidden,
                        edges: [.bottom]
                    ).padding()
                    
                    if (self.selectedId == 0x0) {
                        SellView()
                    } else {
                        BuyView()
                    }
                }
            }.navigationTitle(navigationTitle).toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        /** Navigate to app preference page */
                        PreferenceView()
                    } label: {
                        Image(systemName: "gearshape").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
