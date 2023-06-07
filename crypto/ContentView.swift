//
//  ContentView.swift
//  crypto
//
//  Created by Pavel Sizonenko on 07.06.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CryptoViewModel()

       var body: some View {
           List(viewModel.cryptos.keys.sorted(), id: \.self) { key in
               VStack(alignment: .leading) {
                   Text(key)
                       .font(.headline)
                   Text("Price: \(viewModel.cryptos[key]?.usd ?? 0.0)")
               }
           }
           .onAppear {
               viewModel.loadData()
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
