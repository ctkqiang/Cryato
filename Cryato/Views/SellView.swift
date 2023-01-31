//
//  SellView.swift
//  Cryato
//
//  Created by John Melody Me on 31/01/2023.
//

import SwiftUI

struct SellView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var originalPricePlaceholder: String = ""
    @State private var sellingPricePlaceholder: String = ""
    
    private var sectionOneOriginalPrice = "Original Price"
    private var sectionTwoSellingPrice = "Selling Price"
    
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
                    }
                    
                    Button {
                        print("s")
                    } label: {
                        Text("Calculate")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(self.colorScheme == .dark ? .black : .white)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle)
                    .tint(self.colorScheme == .dark ? .white.opacity(0.8) : .black)
                    .padding()
                    .frame(height: 60)
                    .controlSize(.large)
                }
                
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .background(self.colorScheme == .dark ? .black : .white)
        .refreshable { /** Do nothing here */ }
    }
}

struct SellView_Previews: PreviewProvider {
    static var previews: some View {
        SellView()
    }
}
