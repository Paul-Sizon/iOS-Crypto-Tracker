//
//  ListingView.swift
//  crypto
//
//  Created by Pavel Sizonenko on 08.06.23.
//

import Foundation
import SwiftUI


struct ListingsView: View {
    @ObservedObject var viewModel: CryptoViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(viewModel.cryptos.sorted { $0.value.usd > $1.value.usd }), id: \.key) { item in
                    CardView(name: item.key, price: item.value.usd)
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Cryptocurrency Listings", displayMode: .inline)
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}
