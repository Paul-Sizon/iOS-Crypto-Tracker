//
//  ContentView.swift
//  crypto
//
//  Created by Pavel Sizonenko on 07.06.23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject var viewModel: CryptoViewModel
    
    var body: some View {
        TabView {
            ListingsView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Listings")
                }
            
            WalletView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("My Wallet")
                }
        }
    }
    
}

