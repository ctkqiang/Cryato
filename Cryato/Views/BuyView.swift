//
//  BuyView.swift
//  Cryato
//
//  Created by John Melody Me on 31/01/2023.
//

import SwiftUI

struct BuyView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var originalPricePlaceholder :String = ""
    @State private var buyingPricePlaceholder :String = ""
    @State private var currentProfitPlaceholder :String = ""
    @State private var isShowingResult :Bool = false
    @State private var isInvalidate :Bool = false
    
    private var sectionOneOriginalPrice :String = "Original Price"
    private var sectionTwoBuyingPrice :String = "Buying Price"
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
        
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Arbitraging calculator")) {
                    HStack {
                        Image(systemName: "dollarsign.circle").controlSize(ControlSize.large)
                        TextField(
                            self.sectionOneOriginalPrice,
                            text: self.$originalPricePlaceholder
                        )
                        .frame(height: 60)
                        .keyboardType(.decimalPad)
                        .controlSize(.large)
                        .onChange(of: self.originalPricePlaceholder) { input in
                           try! self.validate(input, 0x0)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "dollarsign.circle").controlSize(ControlSize.large)
                        TextField(
                            self.sectionTwoBuyingPrice,
                            text: self.$buyingPricePlaceholder
                        )
                        .frame(height: 60)
                        .keyboardType(.decimalPad)
                        .controlSize(.large)
                        .onChange(of: self.buyingPricePlaceholder) { input in
                           try! self.validate(input, 0x1)
                        }
                    }
                    
                    Button {
                        let result :Double = (Double(self.originalPricePlaceholder) ?? 0)! - (Double(self.buyingPricePlaceholder) ?? 0)!.roundThreeDigits
                        
                        self.currentProfitPlaceholder = String(format: "%.2f", result)
                        
                        if (!(self.originalPricePlaceholder.isEmpty) && !(self.buyingPricePlaceholder.isEmpty)) {
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
                    .tint(.green)
                    .padding()
                    .frame(height: 60)
                    .controlSize(.large)
                    
                    
                    if self.isShowingResult {
                        let profits :[String] = [ self.currentProfitPlaceholder ]
                        
                        Text("If you buy 1 USDT at $\(self.buyingPricePlaceholder) you \(self.isNegative(profits[0])) $\(profits[0]) .")
                    }
                }
            }.scrollDismissesKeyboard(.interactively)
                .background(self.colorScheme == .dark ? .black : .white)
                .refreshable {
                    self.isShowingResult = false
                    self.buyingPricePlaceholder = ""
                    self.originalPricePlaceholder = ""
                }
        }
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView()
    }
}
