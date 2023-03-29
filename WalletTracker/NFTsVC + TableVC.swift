//
//  NFTsVC + TableVC.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 28.03.2023.
//

import Foundation
import UIKit

extension NFTsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        collectionsNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = 0
        for nft in allNFTs {
            if nft.collectionName == collectionsNames[section] {
                number += 1
            }
        }
        
        return number
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        collectionsNames[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nftsTableView.dequeueReusableCell(withIdentifier: "nftCell", for: indexPath) as! NFTTableViewCell
        
        let indexRow = indexPath.row
    
        cell.nftImageView.load(url: URL(string: allNFTs[indexRow].originalImage.decodeUrl)!) {
            
        }
        cell.nftFloorPriceLabel.text = allNFTs[indexRow].floorPriceString
        
        return cell
    }
    
    
}
