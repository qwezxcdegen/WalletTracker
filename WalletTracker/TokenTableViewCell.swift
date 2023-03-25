//
//  TokenTableViewCell.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 25.03.2023.
//

import UIKit

class TokenTableViewCell: UITableViewCell {

    @IBOutlet weak var tokenWorthLabel: UILabel!
    @IBOutlet weak var tokenImage: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tokenAmountLabel: UILabel!
    @IBOutlet weak var tokenNameLabel: UILabel!
}
