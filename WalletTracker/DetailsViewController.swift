//
//  DetailsViewController.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 25.03.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var tokensTableView: UITableView!
    
    @IBOutlet weak var totalBalanceLabel: UILabel!
    
    @IBOutlet weak var walletAddressLabel: UILabel!
    
    var walletAddress = ""
    
    var tokens: [TokenResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tokensTableView.delegate = self
        self.tokensTableView.dataSource = self
        
        walletAddressLabel.text = walletAddress
        fetchTokensFromAddress()
    }
    
    private func fetchTokensFromAddress() {
        guard let url = URL(string: "https://api.shyft.to/sol/v1/wallet/all_tokens?network=mainnet-beta&wallet=\(walletAddress)") else { return }
        var request = URLRequest(url: url)
        request.addValue("-3iYNcRok7Gm4EMl", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            guard error == nil else { return }
            guard let tokensData = try? JSONDecoder().decode(Token.self, from: data) else { return }
            DispatchQueue.main.async {
                for token in tokensData.result {
                    if token.balance > 0 {
                        self.tokens.append(token)
                    }
                }
                self.tokensTableView.reloadData()
                print(self.tokens)
            }
        }.resume()
    }
}
