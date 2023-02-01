//
//  View.swift
//  Cryato
//
//  Created by John Melody Me on 01/02/2023.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
