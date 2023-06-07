//
//  ContentView.swift
//  crypto
//
//  Created by Pavel Sizonenko on 07.06.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ListingsView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Listings")
                }
                
            WalletView()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("My Wallet")
                }
        }
    }
}

struct ListingsView: View {
    @StateObject var viewModel = CryptoViewModel()

    var body: some View {
        ScrollView {
            ForEach(viewModel.cryptos.sorted { $0.value.usd < $1.value.usd }, id: \.key) { item in
                CardView(name: item.key, price: item.value.usd)
            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}

struct WalletView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AddCoinView()) {
                    Text("Add a new coin")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("My Wallet", displayMode: .inline)
        }
    }
}

struct AddCoinView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Add Coin View")
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            Spacer()
        }
        .padding()
        .navigationBarTitle("Add Coin", displayMode: .inline)
    }
}




//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
