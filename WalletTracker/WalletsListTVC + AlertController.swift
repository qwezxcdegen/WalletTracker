//
//  WalletsListTVC + AlertController.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 23.03.2023.
//

import Foundation
import UIKit

extension WalletsListTableViewController {
    func presentAddAlertController(title: String?, message: String?, style: UIAlertController.Style, completion: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        
        ac.addTextField { tf in
            tf.placeholder = "Your SOL address"
        }
        
        let add = UIAlertAction(title: "Add", style: .default) { action in
            guard let walletAddress = ac.textFields?.first?.text else { return }
            if walletAddress != "" {
                completion(walletAddress)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        ac.addAction(cancel)
        ac.addAction(add)
        
        present(ac, animated: true)
    }
}
