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
                    AsyncImage(
                        url: URL(
                            string: "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"
                        ),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 50, maxHeight: 50)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Text("ETHUSDT").foregroundColor(self.colorScheme == .dark ? .white : .black)
                    AsyncImage(
                        url: URL(
                            string: "https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png"
                        ),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 50, maxHeight: 50)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Text("SHIBUSDT").foregroundColor(self.colorScheme == .dark ? .white : .black)
                    AsyncImage(
                        url: URL(
                            string: "https://s2.coinmarketcap.com/static/img/coins/64x64/23558.png"
                        ),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 50, maxHeight: 50)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Text("XRPUSDT").foregroundColor(self.colorScheme == .dark ? .white : .black)
                    AsyncImage(
                        url: URL(
                            string: "https://s2.coinmarketcap.com/static/img/coins/64x64/52.png"
                        ),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 50, maxHeight: 50)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Text("MATICUSDT").foregroundColor(self.colorScheme == .dark ? .white : .black)
                    AsyncImage(
                        url: URL(
                            string: "https://s2.coinmarketcap.com/static/img/coins/64x64/3890.png"
                        ),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 50, maxHeight: 50)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
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
