//
//  View.swift
//  Cryato
//
//  Created by John Melody Me on 01/02/2023.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

extension View {
    public func hideKeyboard() -> Void {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

