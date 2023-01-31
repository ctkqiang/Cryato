/**
 * MIT License
 *
 * Copyright (c) 2023 John Melody Me
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import SwiftUI

struct ContentView: View {
    /**
     * @author: John Melody Me <Johnmelodyme@icloud.com>
     * @programme: Cryato
     * @description: Cryato is a mobile app that makes crypto arbitrage calculations easy.
     * It is an offline app that allows users to calculate their profits from buying and selling
     * different cryptocurrencies on different exchanges, taking into account the latest
     * exchange rates and market conditions. The app is designed to be simple and easy to
     * use, and does not require any prior knowledge of trading or crypto arbitrage. With
     * Cryato, users can make informed investment decisions and maximize their profits
     * from arbitraging in cryptocurrency.
     */
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
        }.background(self.colorScheme == .dark ? .black : .white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
