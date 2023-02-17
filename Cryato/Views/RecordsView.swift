//
//  RecordsView.swift
//  Cryato
//
//  Created by John Melody Me on 08/02/2023.
//

import SwiftUI

struct RecordsView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private func addRecords() throws -> Void {
        
    }
    
    public var body: some View {
        NavigationView {
            Form {
                VStack {
                    Text("asdassd")
                }
            }
            .navigationBarTitle("Records")
            .scrollDismissesKeyboard(.interactively)
            .refreshable {
                // @TODO
            }
            .toolbar {
                NavigationLink {
                    AddRecordsView()
                } label: {
                    Image(systemName: "doc.fill.badge.plus").foregroundColor(
                        colorScheme.self == .dark ? .white : .black
                    )
                }
               
            }
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    public static var previews: some View {
        RecordsView()
    }
}
