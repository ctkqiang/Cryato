//
//  ScamView.swift
//  Cryato
//
//  Created by John Melody Me on 14/02/2023.
//

import SwiftUI

struct ScamView: View {
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Text("All the Scammers history are listed here")
                }
            }
            .navigationBarTitle("Scams")
            .refreshable {
                // @TODO
            }
        }
    }
}

struct ScamView_Previews: PreviewProvider {
    static var previews: some View {
        ScamView()
    }
}
