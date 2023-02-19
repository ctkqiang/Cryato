//
//  CryptoPriceView.swift
//  Cryato
//
//  Created by John Melody Me on 19/02/2023.
//

import SwiftUI

struct CryptoPriceView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var pricing :[String] = [String]()
    @State private var isGeckoAvailable :Bool = false
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                Button {
                    
                } label: {
                    Text("BTCUSDT").foregroundColor(self.colorScheme == .dark ? .white : .black)
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                
                Button {
                    
                } label: {
                    Text("ETHUSDT").foregroundColor(self.colorScheme == .dark ? .white : .black)
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Text("SHIBUSDT").foregroundColor(self.colorScheme == .dark ? .white : .black)
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Text("XRPUSDT").foregroundColor(self.colorScheme == .dark ? .white : .black)
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Text("MATICUSDT").foregroundColor(self.colorScheme == .dark ? .white : .black)
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
            }.padding()
        }
        .onAppear {
            try! CoinGecko.ping() { result in
                
                if result.gecko_says.contains("(V3) To the Moon!") {
                    self.isGeckoAvailable = true
                }
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct CryptoPriceView_Previews: PreviewProvider {
    public static var previews: some View {
        CryptoPriceView()
    }
}
