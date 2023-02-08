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
            VStack {
                Form {
                    
                }
            }.navigationBarTitle("Records")
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView()
    }
}
