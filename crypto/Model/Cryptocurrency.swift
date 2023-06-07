//
//  Cryptocurrency.swift
//  crypto
//
//  Created by Pavel Sizonenko on 07.06.23.
//

import Foundation

struct Coin: Decodable {
    let usd: Double
}

typealias CryptoResponse = [String: Coin]

