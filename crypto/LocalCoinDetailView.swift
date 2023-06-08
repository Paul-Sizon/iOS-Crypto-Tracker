//
//  LocalCoinDetailView.swift
//  crypto
//
//  Created by Pavel Sizonenko on 08.06.23.
//

import Foundation
import SwiftUI

struct LocalCoinDetailView: View {
    let name: String
    let amount: Double
    let priceInUSD: Double
    let initialPriceInUsd: Double?
    var coinWebsite: URL? {
            CoinWebsite(rawValue: name.lowercased())?.url
        }
    
    var body: some View {
        VStack {
            Text(name)
                .font(.largeTitle)
                .padding()
            
            Text("Amount: \(String(format: "%.4f", amount))")
                .font(.title)
                .padding()
            
            Text("Price in USD: \(String(format: "%.2f", priceInUSD))")
                .font(.title)
                .padding()
            
            if let initialPrice = initialPriceInUsd,
               initialPrice != 0.0,
               initialPrice != priceInUSD,
               name.lowercased() != "usdt" {
                let profitLoss = priceInUSD - initialPrice
                let profitLossPercent = (profitLoss / initialPrice) * 100
                
                Text("Profit/Loss: \(profitLoss > 0 ? "Profit" : "Loss")")
                    .font(.title)
                    .padding()
                
                Text("\(String(format: "%.2f", profitLoss)) (\(String(format: "%.2f", profitLossPercent))%)")
                    .font(.title)
                    .foregroundColor(profitLoss > 0 ? .green : .red)
                    .padding()
            }
        }
        .padding()
        
        if let url = coinWebsite {
                       NavigationLink(destination: CoinWebsiteView(url: url)) {
                           Text("Learn more about \(name)")
                               .font(.body)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10.0)
                       }
                       .padding(.top, 20)
        }
    }
}

struct LocalCoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Learn more about BTC")
            .font(.body)
             .foregroundColor(.black)
             .padding()
             .background(Color.gray.opacity(0.2))
             .cornerRadius(10.0)
    }
}

