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

struct ListingsView: View {
    @ObservedObject var viewModel: CryptoViewModel

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
    @ObservedObject var viewModel: CryptoViewModel

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
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selectedCoin: String = "BTC"
    @State var amount: String = ""
    @State private var showingAlert = false


    let coins = ["BTC", "BNB", "Polygon", "ADA", "DOGE", "ETH", "USD"]

    var body: some View {
        NavigationView {
            Form {
                Picker("Coin", selection: $selectedCoin) {
                    ForEach(coins, id: \.self) { coin in
                        Text(coin)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                Button(action: {
                    addCoin()
                    showingAlert = true
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Coin")
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Success"),
                      message: Text("\(selectedCoin) of \(amount) amount added"),
                      dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Add a Coin")
        }
    }

    private func addCoin() {
        let amountAsDouble = Double(amount) ?? 0.0
        let newCoin = LocalCoin(context: viewContext)
        newCoin.name = selectedCoin
        newCoin.amount = amountAsDouble
        do {
            try viewContext.save()
        } catch {
            print("Unable to save coin: \(error)")
        }
    }
}






//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
