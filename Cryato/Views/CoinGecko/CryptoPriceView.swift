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
               NavigationLink {
                   TradingViewWebView(ticker: "BTCUSDT")
                } label: {
                    HStack {
                        AsyncImage(
                            url: URL(
                                string: "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"
                            ),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 100, maxHeight: 100)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                    }
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                NavigationLink {
                    TradingViewWebView(ticker: "ETHUSDT")
                } label: {
                    AsyncImage(
                        url: URL(
                            string: "https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png"
                        ),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                NavigationLink {
                    TradingViewWebView(ticker: "SHIBUSDT")
                } label: {
                    AsyncImage(
                        url: URL(
                            string: "https://s2.coinmarketcap.com/static/img/coins/64x64/23558.png"
                        ),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                NavigationLink {
                    TradingViewWebView(ticker: "XRPUSDT")
                } label: {
                    AsyncImage(
                        url: URL(
                            string: "https://s2.coinmarketcap.com/static/img/coins/64x64/52.png"
                        ),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
                
                NavigationLink {
                    TradingViewWebView(ticker: "MATICUSDT")
                } label: {
                    AsyncImage(
                        url: URL(
                            string: "https://s2.coinmarketcap.com/static/img/coins/64x64/3890.png"
                        ),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
                .padding()
                .background(self.colorScheme == .dark ? .gray : .white)
                .cornerRadius(10)
            }.padding(6)
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
