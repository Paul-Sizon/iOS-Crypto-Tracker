//
//  WalletView.swift
//  crypto
//
//  Created by Pavel Sizonenko on 08.06.23.
//

import Foundation
import SwiftUI

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
