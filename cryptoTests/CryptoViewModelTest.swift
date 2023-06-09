//
//  CryptoViewModelTest.swift
//  cryptoTests
//
//  Created by Pavel Sizonenko on 09.06.23.
//

import Foundation
import XCTest
@testable import crypto

class CryptoViewModelTests: XCTestCase {
    
    func testLoadData() {
        let mockData: CryptoResponse = [
            "bitcoin": Coin(usd: 10000.0),
            "ethereum": Coin(usd: 3000.0)
        ]
        
        let mockApiService = MockApiService(mockData: mockData)
        
        let viewModel = CryptoViewModel()
        viewModel.apiService = mockApiService
        
        viewModel.loadData()
        
        XCTAssertEqual(viewModel.cryptos["BTC"]?.usd, 10000.0)
        XCTAssertEqual(viewModel.cryptos["ETH"]?.usd, 3000.0)
    }
}
