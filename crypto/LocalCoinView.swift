//
//  LocalCoinView.swift
//  crypto
//
//  Created by Pavel Sizonenko on 08.06.23.
//

import Foundation
import SwiftUI

struct LocalCoinView: View {
    var name: String
    var amount: Double
    var priceInUSD: Double
    var total: Double {
        get {
            priceInUSD * amount
        }
    }
    var initalPriceInUsd: Double?

    var body: some View {
        HStack {
//            TODO: img
            VStack {
                Text(name)
                    .font(.headline).foregroundColor(.white)
            }
            Spacer()
            VStack {
                Text(String(format: "%.4f", amount))
                    .font(.subheadline).bold().foregroundColor(.white)
                Text("$ \(String(format: "%.2f", total))")
                    .font(.subheadline).foregroundColor(.white)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(LinearGradient(
                    gradient: Gradient(colors: gradientColors()),
                    startPoint: .top,
                    endPoint: .bottom
                ))
        .cornerRadius(10)
        .padding([.leading, .trailing])
    }
    
    private func gradientColors() -> [Color] {
            if let initialPrice = initalPriceInUsd,
               initialPrice != 0,
               initialPrice != priceInUSD {
                return priceInUSD > initialPrice ? [.black, .green] : [.black, .red]
            } else {
                return [.black, .yellow]
            }
        }
}

struct LocalCoinView_Previews: PreviewProvider {
    static var previews: some View {
        LocalCoinView(name: "BTC", amount: 3.5, priceInUSD: 3.5*27478, initalPriceInUsd: 3.5 * 3.5 * 27000)
    }
}
