//
//  CoinsIDs.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 26.03.2023.
//

import Foundation

// MARK: - CoinElement
struct Coin: Codable {
    let id, symbol, name: String
}

typealias Coins = [Coin]



// https://api.coingecko.com/api/v3/coins/list
