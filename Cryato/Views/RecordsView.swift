//
//  RecordsView.swift
//  Cryato
//
//  Created by John Melody Me on 08/02/2023.
//

import SwiftUI

struct RecordsView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Text("Records here")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          
                }
            }
            .navigationBarTitle("Records")
            .scrollDismissesKeyboard(.interactively)
            .refreshable {
                // @TODO
            }
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView()
    }
}
