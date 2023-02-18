//
//  AddRecordsView.swift
//  Cryato
//
//  Created by John Melody Me on 17/02/2023.
//

import SwiftUI

#if canImport(AlertToast)
import AlertToast
#endif

struct AddRecordsView: View {
    @Environment(\.presentationMode) private var mode: Binding<PresentationMode>
    
    @State private var dateTime :String = ""
    @State private var unitPurchased :String = ""
    @State private var originalPrice :String = ""
    @State private var sellingPrice :String = ""
    @State private var selectedCrypto :String = CryptoSelector.cryptoCurrenciesChoices[0]
    @State private var showAlertNil :Bool = false
    @State private var showAlertSpec :Bool = false
    
    private var cryptoPair :[String] = CryptoSelector.cryptoCurrenciesChoices
    
    private func earned() throws -> Double {
        return (Double(self.sellingPrice) ?? 0) - (Double(self.originalPrice) ?? 0)
    }
    
    private func saveIntoDatabase() throws -> Void {
        if try! self.unitPurchased.isContainSpecialChars() {
            self.showAlertSpec = true
        }
        
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
            self.mode.wrappedValue.dismiss()
        } else {
            self.showAlertNil = true
            NSLog("The Record field are empty")
        }
    }
    
    public var body: some View {
        
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
                    .keyboardType(.decimalPad)
                
                TextField("What was your selling price?", text: self.$sellingPrice)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                    .keyboardType(.decimalPad)
            }
            
            Button {
                try! self.saveIntoDatabase()
            } label: {
                Text("SAVE TO DATABASE").frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
            .tint(.blue)
            .frame(height: 60)
            .controlSize(.large)
            .padding()
        }
        .scrollDismissesKeyboard(.interactively)
        .toast(isPresenting: self.$showAlertSpec, alert: {
            AlertToast(
                type: .error(.red),
                title: "Warning",
                subTitle: "The unit doesn't have special characters."
            )
        })
        .toast(isPresenting: self.$showAlertNil, alert: {
            AlertToast(
                type: .error(.red),
                title: "Warning",
                subTitle:  "Please fill in all the required field!"
            )
        })
    }
}

struct AddRecordsView_Previews: PreviewProvider {
    public static var previews: some View {
        AddRecordsView()
    }
}
