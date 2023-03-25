//
//  TokenModel.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 25.03.2023.
//

import Foundation
import UIKit

// MARK: - Token
struct Token: Codable {
    let success: Bool
    let message: String
    let result: [TokenResult]
}

// MARK: - Result
struct TokenResult: Codable {
    let address: String
    let balance: Double
    let info: TokenInfo
}

// MARK: - Info
struct TokenInfo: Codable {
    let name, symbol: String
    let image: String
}
