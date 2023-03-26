//
//  DetailsVC + TableVC.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 25.03.2023.
//

import Foundation
import UIKit

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tokens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tokensTableView.dequeueReusableCell(withIdentifier: "tokenCell", for: indexPath) as! TokenTableViewCell
        let index = indexPath.row
        if coins.contains(where: { coin in
            coin.symbol.lowercased() == tokens[index].info.symbol.lowercased()
        }) {
            let coinIndex = coins.firstIndex { coin in
                coin.symbol.lowercased() == tokens[index].info.symbol.lowercased()
            }
            cell.tokenWorthLabel.getCurrencyPrice(id: coins[coinIndex!].id, cell: cell) { totalPrice in
                print("QWEQWEWQEWQ")
                self.totalBalance += totalPrice
            }
            
        }
        if let image = URL(string: tokens[index].info.image.encodeUrl) {
            cell.tokenImage.load(url: image) { _ in
                cell.activityIndicator.stopAnimating()
            }
        }
        cell.tokenImage.layer.cornerRadius = cell.tokenImage.frame.height / 2
        cell.tokenAmountLabel.text = String(round(tokens[index].balance * 10000) / 10000)
        cell.tokenNameLabel.text = tokens[index].info.symbol
        
        return cell
    }
}
