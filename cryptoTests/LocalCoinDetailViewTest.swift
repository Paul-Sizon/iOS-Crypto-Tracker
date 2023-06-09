//
//  LocalCoinDetailViewTest.swift
//  cryptoTests
//
//  Created by Pavel Sizonenko on 09.06.23.
//

import Foundation
import XCTest

class LocalCoinDetailViewTests: XCTestCase {

    func testProfitLossCalculation() {
        let initialPrice = 100.0
        let priceInUSD = 200.0
        let name = "btc"

        if initialPrice != 0.0,
           initialPrice != priceInUSD,
           name.lowercased() != "usdt" {
            let profitLoss = priceInUSD - initialPrice
            let profitLossString = String(format: "%.2f", profitLoss)
            XCTAssertEqual(profitLossString, "100.00")

            let profitLossPercent = (profitLoss / initialPrice) * 100
            let profitLossPercentString = String(format: "%.2f", profitLossPercent)
            XCTAssertEqual(profitLossPercentString, "100.00")
        }
    }
    
    func testLossCalculation() {
        let initialPrice = 100.0
        let priceInUSD = 50.0
        let name = "btc"

        if initialPrice != 0.0,
           initialPrice != priceInUSD,
           name.lowercased() != "usdt" {
            let profitLoss = priceInUSD - initialPrice
            let profitLossString = String(format: "%.2f", profitLoss)
            XCTAssertEqual(profitLossString, "-50.00")

            let profitLossPercent = (profitLoss / initialPrice) * 100
            let profitLossPercentString = String(format: "%.2f", profitLossPercent)
            XCTAssertEqual(profitLossPercentString, "-50.00")
        }
    }

}
