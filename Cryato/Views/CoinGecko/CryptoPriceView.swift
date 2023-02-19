//
//  CryptoPriceView.swift
//  Cryato
//
//  Created by John Melody Me on 19/02/2023.
//

import SwiftUI

struct CryptoPriceView: View {
    @State private var pricing :[String] = [String]()
    @State private var isGeckoAvailable :Bool = false
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                Button("BTCUSDT") {
                    
                }
                .padding()
                .background(.white)
                .cornerRadius(10)
                
                Button("ETHUSDT") {}
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                
                Button("SHIBUSDT") {}
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                
                Button("XRPUSDT") {}
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                
                Button("MATICUSDT"){}
                    .padding()
                    .background(.white)
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
