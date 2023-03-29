//
//  NFTModel.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 28.03.2023.
//

import Foundation

// MARK: - Nft
struct Nft: Codable {
    let name, mint: String
    let symbol: String?
    let lastSalePrice: Int?
    let price, highestBid: JSONNull?
    let description: String?
    let image, originalImage: String
    let externalURL: String?
    let animationURL: JSONNull?
    var collectionSymbol, collectionName: String?
    let marketplace, marketplaceName: JSONNull?
    let royalty: Int
    let rarityRank: Int?
    let buyReward, sellReward, buyLink: JSONNull?
    let floorPrice, collectionItemCount: Int?
    let tokenAccount: String
    let owner: Owner
    let withRoyalty: Bool
    let creators: [Creator]
    let auctionhouses: Auctionhouses
    let transferAuthority: JSONNull?
    
    var floorPriceString: String {
        String(Double(floorPrice ?? 0) / 1000000000) + "◎"
    }

    enum CodingKeys: String, CodingKey {
        case name, mint, symbol
        case lastSalePrice = "last_sale_price"
        case price
        case highestBid = "highest_bid"
        case description, image
        case originalImage = "original_image"
        case externalURL = "external_url"
        case animationURL = "animation_url"
        case collectionSymbol = "collection_symbol"
        case collectionName = "collection_name"
        case marketplace
        case marketplaceName = "marketplace_name"
        case royalty
        case rarityRank = "rarity_rank"
        case buyReward = "buy_reward"
        case sellReward = "sell_reward"
        case buyLink = "buy_link"
        case floorPrice = "floor_price"
        case collectionItemCount = "collection_item_count"
        case tokenAccount = "token_account"
        case owner
        case withRoyalty = "with_royalty"
        case creators, auctionhouses
        case transferAuthority = "transfer_authority"
    }
}

// MARK: - Auctionhouses
struct Auctionhouses: Codable {
}

// MARK: - Creator
struct Creator: Codable {
    let address: String
    let verified: Bool
    let share: Int
}

enum Owner: String, Codable {
    case the5RoD6Qv6Ika9NHde4YbBMq26UEf7E1QEphxMSiALqL9A = "5RoD6Qv6ika9nHde4YbBMq26uEf7E1qEphxMSiALqL9A"
}

typealias NFTs = [Nft]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

//    public var hashValue: Int {
//        return 0
//    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
