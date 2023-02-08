//
//  Scanner.swift
//  Cryato
//
//  Created by John Melody Me on 08/02/2023.
//

import SwiftUI

struct ScannerView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var transactionId :String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        TextField("TransactionId", text: self.$transactionId)
                        .frame(height: 60)
                        .controlSize(.large)
                        
                        
                    }
                }.navigationBarTitle("Scanner")
                    .scrollDismissesKeyboard(.interactively)
                    .background(self.colorScheme == .dark ? .black : .white)
                    .refreshable {}
            }.background(self.colorScheme == .dark ? .black : .white)
        }
    }
}

struct Scanner_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
