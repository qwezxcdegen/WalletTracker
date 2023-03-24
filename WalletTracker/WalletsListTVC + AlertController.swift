//
//  WalletsListTVC + AlertController.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 23.03.2023.
//

import Foundation
import UIKit

extension WalletsListTableViewController {
    func presentAddAlertController(title: String?, message: String?, style: UIAlertController.Style, completion: @escaping (String, String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        
        ac.addTextField { tf in
            tf.placeholder = "Your SOL address"
        }
        ac.addTextField { tf2 in
            tf2.placeholder = "Wallet name"
        }
        
        let add = UIAlertAction(title: "Add", style: .default) { action in
            guard let walletAddress = ac.textFields?.first?.text else { return }
            if let walletName = ac.textFields?.last?.text {
                if walletAddress != "" {
                    completion(walletAddress, walletName)
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        ac.addAction(cancel)
        ac.addAction(add)
        
        present(ac, animated: true)
    }
}
