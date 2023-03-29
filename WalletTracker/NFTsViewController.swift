//
//  NFTsViewController.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 28.03.2023.
//

import UIKit

class NFTsViewController: UIViewController {

    @IBOutlet weak var nftsTableView: UITableView!
    
    var allNFTs: NFTs = []
    var collectionsNames: [String] = []
    
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
                
                self.nftsTableView.reloadData()
            }
        }.resume()
    }
}
