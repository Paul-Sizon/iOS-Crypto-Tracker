//
//  WebView.swift
//  crypto
//
//  Created by Pavel Sizonenko on 08.06.23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = true
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
