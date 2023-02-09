//
//  Scanner.swift
//  Cryato
//
//  Created by John Melody Me on 08/02/2023.
//

import SwiftUI

struct ScannerView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var transactions :[Transactions] = [Transactions]()
    @State private var walletId :String = ""
    
    private var validator :FormValidator = FormValidator()
    
    private func validate(_ value :String, _ mode :Int) throws -> Void {
        if (value.isEmpty) {}
        return
    }
    
    private func getTransactions() -> Void {
        guard let url = URL(
            string: "https://api.trongrid.io/v1/accounts/\(self.walletId)/transactions/trc20"
        ) else {
            print("Url Malfunction or Invalid")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .iso8601
                
                if let decodedResponse = try?
                    decoder.decode([Transactions].self, from: data) {
                    DispatchQueue.main.async {
                        self.transactions = decodedResponse
                    }
                    
                    return
                }
                
            }
            
            print ("Fetch url failed")
            
        }.resume()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    HStack {
                        TextField("Wallet Address", text: self.$walletId)
                            .frame(height: 30)
                            .controlSize(.large)
                            .onChange(of: self.walletId) { input in
                                try! self.validate(input, 0x0)
                            }
                        
                        Button("Search") {
                            print(self.walletId)
                            
                            self.getTransactions()
                        }.foregroundColor(.green)
                    }.textFieldStyle(.roundedBorder)
                }
                .navigationBarTitle("Scanner")
                .scrollDismissesKeyboard(.interactively)
                .scrollContentBackground(.hidden)
                .background(self.colorScheme == .dark ? .black : .white)
                .refreshable { self.walletId = "" }
                .frame(maxHeight: 60)
                
                List {
                    Section {
                        ForEach(0..<5) { i in
                            Section {
                                Text("A new row \(i)")
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.gray.opacity(0.0))
                .onAppear(perform: self.getTransactions)
                .listStyle(.insetGrouped)
            }
            
        }
    }
}

struct Scanner_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
