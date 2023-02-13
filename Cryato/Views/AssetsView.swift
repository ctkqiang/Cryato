//
//  AssetsView.swift
//  Cryato
//
//  Created by John Melody Me on 09/02/2023.
//

import SwiftUI

struct AssetsView: View {
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Text("All the assets are listed here")
                }
            }
            .navigationBarTitle("Assets")
            .refreshable {
                // @TODO
            }
        }
    }
}

struct AssetsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsView()
    }
}
