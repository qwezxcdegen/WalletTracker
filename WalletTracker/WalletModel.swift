//
//  WalletModel.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 23.03.2023.
//

import Foundation

// MARK: - Wallet
struct Wallet: Codable {
    let success: Bool
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let walletName: String?
    let walletAddress: String?
    let sol_balance: Double
    let num_tokens: Int
    let num_nfts: Int
}
