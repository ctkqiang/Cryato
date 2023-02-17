//
//  AssetsView.swift
//  Cryato
//
//  Created by John Melody Me on 09/02/2023.
//

import SwiftUI

struct AssetsView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    public var body: some View {
        NavigationView {
            Form {
                VStack {
                    Text("All the assets are listed here")
                }
            }
            .navigationBarTitle("Assets")
            .refreshable {
                // @TODO
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        /** Navigate to app preference page */
                        PreferenceView()
                    } label: {
                        Image(systemName: "gearshape").foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                    }
                }
            }
        }
    }
}

struct AssetsView_Previews: PreviewProvider {
    public static var previews: some View {
        AssetsView()
    }
}
