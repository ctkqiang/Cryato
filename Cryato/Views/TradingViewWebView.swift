//
//  TradingViewWebView.swift
//  Cryato
//
//  Created by John Melody Me on 24/02/2023.
//

import SwiftUI
#if canImport(WebKit)
import WebKit
#endif

struct WebView: UIViewRepresentable {
    public var htmlFileName: String
    
    private let webView: WKWebView = WKWebView()
    
    public func makeUIView(context: Context) -> WKWebView {
        self.webView.scrollView.delegate = nil
        return self.webView
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
        self.webView.scrollView.delegate = nil
        try! webView.load(self.htmlFileName)
    }
}

extension WKWebView {
    
    public func load(_ html: String) throws -> Void {
        guard !html.isEmpty else {
            return NSLog("Empty html file")
        }
        
        guard let filePath = Bundle.main.path(forResource: html, ofType: "html") else {
            return NSLog("Error file path")
        }
        
        do {
            let htmlString = try! String(contentsOfFile: filePath, encoding: .utf8)
            loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: filePath))
        }
        
    }
}

struct TradingViewWebView: View {
    public var ticker: String
    
    
    
    var body: some View {
        WebView(htmlFileName: ticker)
    }
}

