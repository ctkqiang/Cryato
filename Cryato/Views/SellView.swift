//
//  SellView.swift
//  Cryato
//
//  Created by John Melody Me on 31/01/2023.
//

import SwiftUI

struct SellView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var originalPricePlaceholder :String = ""
    @State private var sellingPricePlaceholder :String = ""
    @State private var currentProfitPlaceholder :String = ""
    @State private var unitPlaceholder :String = ""
    @State private var selectedCurrency :String = CryptoSelector.cryptoCurrenciesChoices[0]
    @State private var isShowingResult :Bool = false
    @State private var isInvalidate :Bool = false
    
    private var sectionOneOriginalPrice :String = "What's the original price?"
    private var sectionTwoSellingPrice :String = "What's the price you selling?"
    private var sectionTwoSellingUnit :String = "How many you sell?"
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
            self.sellingPricePlaceholder = value
        }
        
        return
    }
    
    private func customerOrderQuantity(_ value :String, _ quant :Double) -> String {
        return String(format: "%.2f", (Double(self.currentProfitPlaceholder) ?? 0)! * quant)
    }
    
    private func isNegative(_ value :String) -> String {
        return (Double(value) ?? 0 < 0) ? "losses": "profits"
    }
    
    var body: some View {
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
                            Text("Cryptocurrency").font(Font.system(size: 20))
                        }
                        .frame(height:60)
                        .font(Font.system(size: 20))
                        .pickerStyle(.menu)
                            
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
                            self.sectionTwoSellingPrice,
                            text: self.$sellingPricePlaceholder
                        )
                        .frame(height: 60)
                        .font(Font.system(size: 20))
                        .textFieldStyle(.plain)
                        .listRowSeparator(.hidden)
                        .keyboardType(.decimalPad)
                        .controlSize(.large)
                        .onChange(of: self.sellingPricePlaceholder) { input in
                            try! self.validate(input, 0x1)
                        }
                        
                        TextField(
                            self.sectionTwoSellingUnit,
                            text: self.$unitPlaceholder
                        )
                        .frame(height: 60)
                        .font(Font.system(size: 20))
                        .textFieldStyle(.plain)
                        .listRowSeparator(.hidden)
                        .keyboardType(.decimalPad)
                        .onChange(of: self.originalPricePlaceholder) { input in
                            try! self.validate(input, 0x0)
                        }
                        
                        Button {
                            let result :Double = (Double(self.sellingPricePlaceholder) ?? 0)! - (Double(self.originalPricePlaceholder) ?? 0)!.roundThreeDigits
                            
                            self.currentProfitPlaceholder = String(format: "%.2f", result)
                            
                            if (!(self.originalPricePlaceholder.isEmpty) && !(self.sellingPricePlaceholder.isEmpty)) {
                                self.isShowingResult = true
                            }
                            
                            if(self.originalPricePlaceholder == "" && self.currentProfitPlaceholder == "") {
                                self.isInvalidate = true;
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
                        .tint(.red)
                        .padding()
                        .frame(height: 60)
                        .controlSize(.large)
                    }
                }.scrollContentBackground(.hidden)
                
                if !self.isShowingResult { // @TODO change to true
                    VStack {
                        Text("RESULTS HERE")
                    }
                }
                
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .background(self.colorScheme == .dark ? .black : .white)
        .refreshable {
            self.isShowingResult = false
            self.sellingPricePlaceholder = ""
            self.originalPricePlaceholder = ""
        }
    }
}

struct SellView_Previews: PreviewProvider {
    static var previews: some View {
        SellView()
    }
}
