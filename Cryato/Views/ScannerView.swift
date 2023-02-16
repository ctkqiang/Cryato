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

#if canImport(Toast)
import Toast
#endif

#if canImport(AlertToast)
import AlertToast
#endif

struct ScannerView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.openURL) private var openURL
    
    @State private var transaction :[Transaction] = [Transaction]()
    @State private var walletId :String = ""
    @State private var showAlert :Bool = false
    @State private var showSafari :Bool = false
    @State private var selectedCurrency :String = CryptoSelector.cryptoCurrenciesChoices[0]
    
    private var validator :FormValidator = FormValidator()
    
    private func validate(_ value :String, _ mode :Int) throws -> Void {
        if (value.isEmpty) {}; return
    }
    
    @available(iOS, deprecated: 6.0, obsoleted: 7.0, message: "No longer in need")
    private func parseData(_ json: Data) -> Void {
        let decoder = JSONDecoder()
        
        if (try? decoder.decode(Transactions.self, from: json)) != nil {
            // self.transaction = listOfTransactions.data
        }
    }
    
    private func search() throws -> Void {
        /** Return API to Listview */
        
        if try! self.walletId.isContainSpecialChars() {
            self.showAlert = true
            
            NSLog("User Input an invalid Wallet Address")
        }
        
        Task {
            TransactionsHelper.loadTransactions(WalletID: self.walletId) { (result) in
                self.transaction = result.data ?? []
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Wallet Address (TRC20)", text: self.$walletId)
                        .frame(height: 30)
                        .controlSize(.large)
                        .onChange(of: self.walletId) { input in
                            try! self.validate(input, 0x0)
                        }
                }
                .navigationBarTitle("Scanner")
                .background(self.colorScheme == .dark ? .black : .gray.opacity(0.0))
                .frame(maxHeight: 70)
                
                List(self.transaction) { data in
                    
                    if data.transaction_id.isEmpty {
                        Text("No Transactions Found")
                    } else {
                        Button(action: {
                            self.walletId = data.from
                            
                            showSafari.toggle()
                            
                            NSLog("\(data)")
                            
                        }) {
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
                            .background(Color.gray.opacity(0.1))
                            .scrollDismissesKeyboard(.interactively)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5).stroke(
                                    .gray.opacity(0.3),
                                    lineWidth: 1
                                )
                            )
                        }
                        .background(.white.opacity(0.1))
                    }
                }
                .scrollContentBackground(.hidden)
                .refreshable {
                    self.walletId = ""
                    self.showAlert = false
                }
                .onAppear {
                    /** Remove Underline */
                    UITableView.appearance().separatorStyle = .none
                }
                .scrollDismissesKeyboard(.interactively)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
                .listStyle(.plain)
            }
            .toast(isPresenting: self.$showAlert, alert: {
                AlertToast(
                    type: .error(.red),
                    title: "Warning",
                    subTitle: "Please Input a Valid Wallet Address"
                )
            })
            .background(.gray.opacity(0.1))
            .fullScreenCover(isPresented: $showSafari, content: {
                SFSafariViewWrapper(url:URL(string:"https://tronscan.org/#/address/\(self.walletId)")!)
            })
            .scrollDismissesKeyboard(.interactively)
            .onSubmit { try! self.search() }
            .submitLabel(.search)
        }
    }
}

struct Scanner_Previews: PreviewProvider {
    public static var previews: some View {
        ScannerView()
    }
}
