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
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var scam :[Scam] = [Scam]()
    @State private var isListView :Bool = true
    
    public init() {
        self.scam = []
    }
    
    private func onLoad() throws -> Void {
        Task {
            ScamListHandler.loadScamList() { result in
                self.scam = result
            }
        }
    }
    
    public var body: some View {
        NavigationStack {
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
            .toolbar {
                NavigationLink {
                    AddScamList()
                } label: {
                    Image(systemName: "person.badge.plus").foregroundColor(
                        colorScheme.self == .dark ? .white : .black
                    )
                }
            }
            .refreshable {
                self.scam = []
                try! self.onLoad()
                if self.isListView == false {
                    self.isListView = true
                }
            }
        }.onAppear {
            self.isListView = true
            try! self.onLoad()
        }
        .onChange(of: self.scenePhase) { newPhrase in
            if newPhrase == .active {
                self.isListView = true
                try! self.onLoad()
            }
        }
    }
}

struct ScamView_Previews: PreviewProvider {
    static var previews: some View {
        ScamView()
    }
}
