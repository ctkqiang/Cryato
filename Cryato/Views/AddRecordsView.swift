//
//  AddRecordsView.swift
//  Cryato
//
//  Created by John Melody Me on 17/02/2023.
//

import SwiftUI

struct AddRecordsView: View {
    @State private var dateTime :String = ""
    @State private var unitPurchased :String = ""
    @State private var originalPrice :String = ""
    @State private var sellingPrice :String = ""
    @State private var selectedCrypto :String = CryptoSelector.cryptoCurrenciesChoices[0]
    
    private var cryptoPair :[String] = CryptoSelector.cryptoCurrenciesChoices
    
    private func earned() throws -> Double {
        return (Double(self.sellingPrice) ?? 0) - (Double(self.originalPrice) ?? 0)
    }
    
    private func saveIntoDatabase() throws -> Void {
        if !self.selectedCrypto.isEmpty &&
        !self.unitPurchased.isEmpty &&
            !self.originalPrice.isEmpty &&
            !self.sellingPrice.isEmpty {
            try! DatabaseManager().addRecord(
                unitPurchased: Int64(self.unitPurchased),
                originalPrice: Double(self.originalPrice),
                sellingPrice: Double(self.sellingPrice),
                crypto: self.selectedCrypto,
                earned: try! self.earned()
            )
        }
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                Form {
                    Picker("What Crypto-currency have you sold", selection: self.$selectedCrypto) {
                        ForEach(self.cryptoPair, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("How many unit(s) do you sell?", text: self.$unitPurchased)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                        .disableAutocorrection(true)
                    
                    TextField("What was your selling price?", text: self.$sellingPrice)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                        .disableAutocorrection(true)
                }
                .navigationTitle("Add Record")
                
                Button {
                    try! self.saveIntoDatabase()
                } label: {
                    Text("SAVE TO DATABASE")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle)
                        .tint(.green)
                        .frame(height: 10)
                        .controlSize(.large)
                        .padding()
                }
            }
        }.scrollDismissesKeyboard(.interactively)
    }
}

struct AddRecordsView_Previews: PreviewProvider {
    public static var previews: some View {
        AddRecordsView()
    }
}
