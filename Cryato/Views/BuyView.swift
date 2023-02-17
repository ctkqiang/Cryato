//
//  BuyView.swift
//  Cryato
//
//  Created by John Melody Me on 31/01/2023.
//

import SwiftUI

#if canImport(Toast)
import Toast
#endif

#if canImport(AlertToast)
import AlertToast
#endif

struct BuyView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var originalPricePlaceholder :String = ""
    @State private var buyingPricePlaceholder :String = ""
    @State private var currentProfitPlaceholder :String = ""
    @State private var currentunitPlaceholder :String = ""
    @State private var selectedCurrency :String = CryptoSelector.cryptoCurrenciesChoices[0]
    @State private var isShowingResult :Bool = false
    @State private var isInvalidate :Bool = false
    @State private var isProfit :Bool = false
    @State private var showAlert :Bool = false
    
    private var sectionOneOriginalPrice :String = "What's the original price?"
    private var sectionTwoBuyingPrice :String = "What's the price you bought?"
    private var sectionThreeBuyUnit :String = "How many you bought?"
    private var calculator :Calculator = Calculator()
    private var validator :FormValidator = FormValidator()
    
    private func validate(_ value :String, _ mode :Int) throws -> Void {
        if (value.isEmpty) {
            self.isInvalidate = true
        }
        
        if (mode == 0x0) {
            self.originalPricePlaceholder = value
        }
        else {
            self.buyingPricePlaceholder = value
        }
        
        return
    }
    
    private func customerOrderQuantity(_ value :String, _ quant :Double) -> String {
        return String(format: "%.2f", (Double(self.currentProfitPlaceholder) ?? 0)! * quant)
    }
    
    private func isNegative(_ value :String) -> String {
        return (Double(value) ?? 0 < 0) ? "losses": "saved"
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Arbitraging calculator")) {
                        VStack {
                            Picker(selection: self.$selectedCurrency) {
                                ForEach(CryptoSelector.cryptoCurrenciesChoices, id:\.self) {
                                    Text($0)
                                }
                                
                                Text(self.selectedCurrency).foregroundColor(.black)
                            } label: {
                                Text("Cryptocurrency")
                                    .font(Font.system(size: 20))
                                    .foregroundColor(.gray)
                            }
                            .frame(height:60)
                            .font(Font.system(size: 20))
                            .pickerStyle(.menu)
                            .onChange(of: self.selectedCurrency) { currency in
                                self.selectedCurrency = currency
                            }
                            
                            TextField(
                                self.sectionOneOriginalPrice,
                                text: self.$originalPricePlaceholder
                            )
                            .frame(height:60)
                            .font(Font.system(size: 20))
                            .textFieldStyle(.plain)
                            .listRowSeparator(.hidden)
                            .keyboardType(.decimalPad)
                            .onChange(of: self.originalPricePlaceholder) { input in
                                try! self.validate(input, 0x0)
                            }
                            
                            TextField(
                                self.sectionTwoBuyingPrice,
                                text: self.$buyingPricePlaceholder
                            )
                            .frame(height: 60)
                            .font(Font.system(size: 20))
                            .textFieldStyle(.plain)
                            .listRowSeparator(.hidden)
                            .keyboardType(.decimalPad)
                            .controlSize(.large)
                            .onChange(of: self.buyingPricePlaceholder) { input in
                                try! self.validate(input, 0x1)
                            }
                            
                            TextField(
                                self.sectionThreeBuyUnit,
                                text: self.$currentunitPlaceholder
                            )
                            .frame(height: 60)
                            .font(Font.system(size: 20))
                            .textFieldStyle(.plain)
                            .listRowSeparator(.hidden)
                            .keyboardType(.decimalPad)
                            .onChange(of: self.currentunitPlaceholder) { input in  }
                            
                            Button {
                                if (!(self.originalPricePlaceholder.isEmpty) && !(self.buyingPricePlaceholder.isEmpty) &&
                                    !(self.currentunitPlaceholder.isEmpty)
                                ) {
                                    self.isShowingResult = true
                                    
                                    if try! Calculator.saved(
                                        original: self.originalPricePlaceholder,
                                        buying: self.buyingPricePlaceholder,
                                        unit: self.currentunitPlaceholder,
                                        cryptoCurrency: self.selectedCurrency
                                    )[1] == PNL.SAVED.rawValue {
                                        self.isProfit = true
                                    }
                                }
                                
                                if(self.originalPricePlaceholder == "" &&
                                   self.currentProfitPlaceholder == "" &&
                                   self.currentunitPlaceholder == ""
                                ) {
                                    self.isInvalidate = true;
                                    self.showAlert = true;
                                }
                                
                                hideKeyboard()
                                
                            } label: {
                                Text("Calculate")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .foregroundColor(.white)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.roundedRectangle)
                            .tint(.green)
                            .frame(height: 60)
                            .controlSize(.large)
                        }
                        
                        if self.isShowingResult {
                            VStack {
                                Text(
                                    try! Calculator.saved(
                                        original: self.originalPricePlaceholder,
                                        buying: self.buyingPricePlaceholder,
                                        unit: self.currentunitPlaceholder,
                                        cryptoCurrency: self.selectedCurrency
                                    )[0]
                                )
                                .foregroundColor(self.isProfit ? .green : .red)
                                .font(.headline)
                            }
                        }
                    }
                }
                .scrollDismissesKeyboard(.interactively)
                .background(self.colorScheme == .dark ? .black : .white)
                .refreshable {
                    self.isShowingResult = false
                    self.buyingPricePlaceholder = ""
                    self.originalPricePlaceholder = ""
                    self.currentunitPlaceholder = ""
                    self.isProfit = false
                }
                .toast(isPresenting: self.$showAlert, alert: {
                    AlertToast(
                        type: .error(.red),
                        title: "Warning",
                        subTitle: "Please fill in all the required field!"
                    )
                })
            }
        }
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView()
    }
}
