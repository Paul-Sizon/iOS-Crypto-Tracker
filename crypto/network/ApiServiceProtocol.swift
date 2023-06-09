//
//  ApiServiceProtocol.swift
//  crypto
//
//  Created by Pavel Sizonenko on 09.06.23.
//

import Foundation

protocol ApiServiceProtocol {
    func getCryptoData(completion: @escaping ([String: Coin]) -> Void)
}
