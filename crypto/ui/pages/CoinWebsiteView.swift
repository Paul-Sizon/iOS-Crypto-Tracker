//
//  CoinWebsite.swift
//  crypto
//
//  Created by Pavel Sizonenko on 08.06.23.
//

import Foundation
import SwiftUI
import WebKit

struct CoinWebsiteView: View {
    let url: URL
    
    var body: some View {
        WebView(url: url)
    }
}
