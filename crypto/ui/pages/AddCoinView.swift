//
//  AddCoinView.swift
//  crypto
//
//  Created by Pavel Sizonenko on 08.06.23.
//

import Foundation
import SwiftUI

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
