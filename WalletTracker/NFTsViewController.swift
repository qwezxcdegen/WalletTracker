//
//  NFTsViewController.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 28.03.2023.
//

import UIKit

class NFTsViewController: UIViewController {

    @IBOutlet weak var nftsTableView: UITableView!
    @IBOutlet weak var totalWorthLabel: UILabel!
    @IBOutlet weak var totalWorthUsdLabel: UILabel!
    
    var allNFTs: NFTs = []
    var allNFTsForTV: [NFTs] = [] {
        didSet {
            totalWorthLabel.text = String(format: "%.2f%", allNFTsForTV.flatMap { $0 }.map { Double($0.floorPriceString[$0.floorPriceString.startIndex..<$0.floorPriceString.index(before: $0.floorPriceString.endIndex)]) ?? 0 }.reduce(0) { $0 + $1 })
            totalWorthUsdLabel.getSolPrice { price in
                self.totalWorthUsdLabel.text = String(format: "%.2f%", (price * Double(self.totalWorthLabel.text!)!))
            }
            
        }
    }
    var collectionsNames: [String] = []
    
    var solPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nftsTableView.delegate = self
        self.nftsTableView.dataSource = self
        fetchNFTsFromAddress("5RoD6Qv6ika9nHde4YbBMq26uEf7E1qEphxMSiALqL9A")
    }
    
    private func fetchNFTsFromAddress(_ walletAddress: String) {
        guard let url = URL(string: "https://api.coralcube.io/v1/getUserProfile?pubkey=\(walletAddress)") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else { return }
            guard let nftsData = try? JSONDecoder().decode(NFTs.self, from: data) else { return }
            DispatchQueue.main.async {
                self.allNFTs = nftsData.sorted { $0.collectionName ?? "Unknown collection" < $1.collectionName ?? "Unknown collection"}
                self.collectionsNames = Set(nftsData.map { $0.collectionName ?? "Unknown collection"}).sorted { $0 < $1 }
                
                for i in 0..<self.allNFTs.count {
                    if let _ = self.allNFTs[i].collectionName {
                        continue
                    }
                    self.allNFTs[i].collectionName = "Unknown collection"
                }
                
                for _ in 0..<self.collectionsNames.count {
                    self.allNFTsForTV.append(NFTs())
                }
                for i in 0..<self.allNFTsForTV.count {
                    for j in 0..<self.allNFTs.count {
                        if self.collectionsNames[i] == self.allNFTs[j].collectionName {
                            self.allNFTsForTV[i].append(self.allNFTs[j])
                        }
                    }
                }
                
                self.nftsTableView.reloadData()
                print(self.collectionsNames)
                print(self.allNFTs)
            }
        }.resume()
    }
}
