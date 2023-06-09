//
//  MockApiService.swift
//  crypto
//
//  Created by Pavel Sizonenko on 09.06.23.
//

import Foundation
import XCTest
@testable import crypto

class MockApiService: ApiServiceProtocol {
    var mockData: CryptoResponse
    
    init(mockData: CryptoResponse) {
        self.mockData = mockData
    }
    
    func getCryptoData(completion: @escaping ([String: Coin]) -> Void) {
        completion(mockData)
    }
}
