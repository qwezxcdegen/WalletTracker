//
//  WalletModel.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 23.03.2023.
//

import Foundation

struct Wallet: Codable {
    let success: Bool
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let balance: Double
}
