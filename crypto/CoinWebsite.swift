//
//  CoinWebsite.swift
//  crypto
//
//  Created by Pavel Sizonenko on 08.06.23.
//

import Foundation

enum CoinWebsite: String {
    case btc = "btc"
    case eth = "eth"
    case bnb = "bnb"
    case usdt = "usdt"
    case ada = "ada"
    case polygon = "polygon"
    case doge = "doge"

    var url: URL? {
        switch self {
        case .btc:
            return URL(string: "https://bitcoin.org/")
        case .eth:
            return URL(string: "https://ethereum.org/")
        case .bnb:
            return URL(string: "https://www.binance.com/")
        case .usdt:
            return URL(string: "https://tether.to/")
        case .ada:
            return URL(string: "https://cardano.org/")
        case .polygon:
            return URL(string: "https://polygon.technology/")
        case .doge:
            return URL(string: "http://dogecoin.com/")
        }
    }
}


