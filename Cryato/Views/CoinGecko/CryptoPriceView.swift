//
//  CryptoPriceView.swift
//  Cryato
//
//  Created by John Melody Me on 19/02/2023.
//

import SwiftUI

struct CryptoPriceView: View {
    @State private var pricing :[String] = [String]()
    
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
        }.background(Color(UIColor.systemGroupedBackground))
    }
}

struct CryptoPriceView_Previews: PreviewProvider {
    public static var previews: some View {
        CryptoPriceView()
    }
}
