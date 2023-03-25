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
        if let image = URL(string: tokens[index].info.image.encodeUrl) {
            cell.tokenImage.load(url: image) { _ in
                cell.activityIndicator.stopAnimating()
            }
        }
        cell.tokenAmountLabel.text = String(tokens[index].balance)
        cell.tokenNameLabel.text = tokens[index].info.symbol
        
        return cell
    }
}
