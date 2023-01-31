//
//  BuyView.swift
//  Cryato
//
//  Created by John Melody Me on 31/01/2023.
//

import SwiftUI

struct BuyView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var originalPricePlaceholder: String = ""
    
    private var sectionOneOriginalPrice = "Original Price"
    private var textFieldPhoriginalPrice = "Input the original price"
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text(self.sectionOneOriginalPrice)) {
                    TextField(self.textFieldPhoriginalPrice, text: self.$originalPricePlaceholder)
                }
            }
        }
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView()
    }
}
