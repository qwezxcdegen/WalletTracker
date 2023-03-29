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
        allNFTsForTV.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNFTsForTV[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        collectionsNames[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nftsTableView.dequeueReusableCell(withIdentifier: "nftCell", for: indexPath) as! NFTTableViewCell
        
        cell.nftImageView.load(url: URL(string: allNFTsForTV[indexPath.section][indexPath.row].image)!) {
            cell.activityIndicator.stopAnimating()
        }
        cell.nftFloorPriceLabel.text = allNFTsForTV[indexPath.section][indexPath.row].floorPriceString

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        print("\(allNFTsForTV[section].map { $0.floorPriceString })")
        return "Total price: \(allNFTsForTV[section].map { Double($0.floorPriceString[$0.floorPriceString.startIndex..<$0.floorPriceString.index(before: $0.floorPriceString.endIndex)]) ?? 0 }.reduce(0) { $0 + $1 }) ◎"
    }
}
