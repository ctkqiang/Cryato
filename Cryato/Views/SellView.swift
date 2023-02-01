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
    @State private var isShowingResult :Bool = false
    @State private var isInvalidate :Bool = false
    
    private var sectionOneOriginalPrice :String = "Original Price"
    private var sectionTwoSellingPrice :String = "Selling Price"
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
                            self.sectionTwoSellingPrice,
                            text: self.$sellingPricePlaceholder
                        )
                        .frame(height: 60)
                        .keyboardType(.decimalPad)
                        .controlSize(.large)
                        .onChange(of: self.sellingPricePlaceholder) { input in
                           try! self.validate(input, 0x1)
                        }
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
                
                
                if self.isShowingResult {
                    
                    let profits :[String] = [
                        self.currentProfitPlaceholder,
                        self.customerOrderQuantity(self.currentProfitPlaceholder, 10),
                        self.customerOrderQuantity(self.currentProfitPlaceholder, 100),
                        self.customerOrderQuantity(self.currentProfitPlaceholder, 1000),
                        self.customerOrderQuantity(self.currentProfitPlaceholder, 10000)
                    ]
                    
                    Text("If they bought $1 you got $\(profits[0]) of \(self.isNegative(profits[0])).")
                    Text("If they bought $10 you got $\(profits[1]) of \(self.isNegative(profits[1])).")
                    Text("If they bought $100 you got $\(profits[2]) of \(self.isNegative(profits[2])).")
                    Text("If they bought $1000 you got $\(profits[3]) of \(self.isNegative(profits[3])).")
                    Text("If they bought $1000 you got $\(profits[4]) of \(self.isNegative(profits[4])).")
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
