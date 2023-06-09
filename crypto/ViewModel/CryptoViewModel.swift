//
//  CryptoViewModel.swift
//  crypto
//
//  Created by Pavel Sizonenko on 07.06.23.
//

import Foundation

class CryptoViewModel: ObservableObject {
    @Published var cryptos = [String: Coin]()
    
    let coinNameMapping: [String: String] = [
        "bitcoin": "BTC",
        "binancecoin": "BNB",
        "matic-network": "Polygon",
        "cardano": "ADA",
        "dogecoin": "DOGE",
        "ethereum": "ETH",
        "tether": "USDT"
    ]
    
    var apiService: ApiServiceProtocol = ApiService()
    
    func loadData() {
        self.cryptos = [:]
        apiService.getCryptoData { (cryptos) in
            var mappedCryptos = [String: Coin]()
            for (key, value) in cryptos {
                let newKey = self.coinNameMapping[key, default: String(key.capitalized)]
                mappedCryptos[newKey] = value
            }
            self.cryptos = mappedCryptos
        }
    }
}

