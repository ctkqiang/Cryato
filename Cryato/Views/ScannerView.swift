//
//  Scanner.swift
//  Cryato
//
//  Created by John Melody Me on 08/02/2023.
//

import SwiftUI
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct ScannerView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var transaction :[Transaction] = [Transaction]()
    @State private var walletId :String = ""
    
    private var validator :FormValidator = FormValidator()
    
    private func validate(_ value :String, _ mode :Int) throws -> Void {
        if (value.isEmpty) {}
        return
    }
    
    @available(iOS, deprecated: 6.0, obsoleted: 7.0, message: "No longer in need")
    private func parseData(_ json: Data) -> Void {
        let decoder = JSONDecoder()
        
        if (try? decoder.decode(Transactions.self, from: json)) != nil {
            // self.transaction = listOfTransactions.data
        }
        
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
                        
                        Button(action: {
                            /** Return API to Listview */
                            
                            Task {
                                TransactionsHelper.loadTransactions(WalletID: self.walletId) { (result) in
                                    self.transaction = result.data ?? []
                                }
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .frame(height:20)
                        }
                    }
                }
                .navigationBarTitle("Scanner")
                .scrollDismissesKeyboard(.interactively)
                .background(self.colorScheme == .dark ? .black : .gray.opacity(0.1))
                .refreshable { self.walletId = "" }
                .frame(maxHeight: 60)
                
                List(self.transaction) { data in
                    
                    VStack(alignment: .leading) {
                        Text("Transaction ID: \(data.transaction_id)")
                            .listRowSeparator(.hidden)
                            .font(Font.system(size: 12))
                        
                        Text("Transaction FROM: \(data.from)")
                            .listRowSeparator(.hidden)
                            .font(Font.system(size: 12))
                        
                        Text("Transaction TO: \(data.to)")
                            .listRowSeparator(.hidden)
                            .font(Font.system(size: 12))
                        
                        Text("Transaction VALUE: \(data.value)")
                            .listRowSeparator(.hidden)
                            .font(Font.system(size: 12))
                        
                        Text("BLOCK TIMESTAMP: \(data.block_timestamp)")
                            .listRowSeparator(.hidden)
                            .font(Font.system(size: 12))
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.3), lineWidth: 1))
                }
                .onAppear {
                    /** Remove Underline */
                    UITableView.appearance().separatorStyle = .none
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
                .background(.gray.opacity(0.0))
                .listStyle(.plain)
            }
            .scrollContentBackground(.hidden)
            .refreshable {
                self.walletId = ""
            }
        }
    }
}

struct Scanner_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
