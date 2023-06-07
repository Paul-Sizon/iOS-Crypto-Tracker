//
//  CryptoViewModel.swift
//  crypto
//
//  Created by Pavel Sizonenko on 07.06.23.
//

import Foundation

class CryptoViewModel: ObservableObject {
    @Published var cryptos = [String: Coin]()

    func loadData() {
        ApiService().getCryptoData { (cryptos) in
            self.cryptos = cryptos
        }
    }
}
