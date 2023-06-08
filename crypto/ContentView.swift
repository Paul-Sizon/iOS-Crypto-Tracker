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



struct WalletView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: LocalCoin.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \LocalCoin.name, ascending: true)]
    )
    private var fetchedCoins: FetchedResults<LocalCoin>
    private var coins: [LocalCoin] {
            fetchedCoins.sorted {
                guard let coinName1 = $0.name, let coinName2 = $1.name,
                      let coinPrice1 = viewModel.cryptos[coinName1]?.usd,
                      let coinPrice2 = viewModel.cryptos[coinName2]?.usd
                else { return false }
                
                return $0.amount * coinPrice1 > $1.amount * coinPrice2
            }
        }

    @ObservedObject var viewModel: CryptoViewModel

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(coins, id: \.self) { coin in
                        if let coinName = coin.name,
                           let coinPrice = viewModel.cryptos[coinName]?.usd {
                            LocalCoinView(name: coinName, amount: coin.amount, priceInUSD: coinPrice, initalPriceInUsd: coin.initialPrice)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())

                NavigationLink(destination: AddCoinView(viewModel: viewModel)) {
                    Text("Add a new coin")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationBarTitle("My Wallet", displayMode: .inline)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { coins[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}




struct AddCoinView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selectedCoin: String = "BTC"
    @State var amount: String = ""
    @State private var showingAlert = false

    @ObservedObject var viewModel: CryptoViewModel

    let coins = ["BTC", "BNB", "Polygon", "ADA", "DOGE", "ETH", "USDT"]

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
        newCoin.initialPrice = viewModel.cryptos[selectedCoin]?.usd ?? 0
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
