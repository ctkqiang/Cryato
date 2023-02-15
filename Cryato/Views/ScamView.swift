//
//  ScamView.swift
//  Cryato
//
//  Created by John Melody Me on 14/02/2023.
//

import SwiftUI

#if canImport(SwiftUI_FAB)
import SwiftUI_FAB
#endif

struct ScamView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @State private var scam :[Scam] = [Scam]()
    
    public init() {
        self.scam = []
    }
    
    private func onLoad() throws -> Void {
        Task {
            ScamListHandler.loadScamList() { result in
                print(result)
                self.scam = result
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                List(self.scam) { data in
                    Section(header: Text("Scammer User ID: \(data.userId!)")) {
                        Button() {
                            // Do Nothing
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Wallet ID: \(data.walletId == "" ? "Not Specified" : data.walletId!)")
                                    .listRowSeparator(.hidden)
                                    .font(Font.system(size: 12))
                                Text("Payment Method: \(data.paymentMethod!)")
                                    .listRowSeparator(.hidden)
                                    .font(Font.system(size: 12))
                                Text("Currency: \(data.currency!)")
                                    .listRowSeparator(.hidden)
                                    .font(Font.system(size: 12))
                                Text("Platform: \(data.platform!)")
                                    .listRowSeparator(.hidden)
                                    .font(Font.system(size: 12))
                                Text("Reported By: \(data.reportedBy!)")
                                    .listRowSeparator(.hidden)
                                    .font(Font.system(size: 12))
                                Text("Scam Technique: \"\(data.scamTechnique!)\"")
                                    .listRowSeparator(.hidden)
                                    .font(Font.system(size: 12))
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Scams")
            .refreshable {
                self.scam = []
                try! self.onLoad()
            }
        }.onAppear {
            try! self.onLoad()
        }
        .onChange(of: self.scenePhase) { newPhrase in
            if newPhrase == .active {
                try! self.onLoad()
            }
        }.floatingActionButton(
            color: .black,
            image: Image(systemName: "plus") .foregroundColor(.white)) {
            
                // @TODO add request 
        }
    }
}

struct ScamView_Previews: PreviewProvider {
    static var previews: some View {
        ScamView()
    }
}
