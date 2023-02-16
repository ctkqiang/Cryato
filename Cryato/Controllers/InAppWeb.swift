//
//  InAppWeb.swift
//  Cryato
//
//  Created by John Melody Me on 14/02/2023.
//

import SwiftUI

#if canImport(SafariServices)
import SafariServices
#endif

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    public func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}
