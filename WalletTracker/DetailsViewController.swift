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
    
    var walletName = ""
    var walletAddress = ""
    var solBalance = 0.0
    var totalBalance = 0.0 {
        didSet {
            totalBalanceLabel.text = String(round(totalBalance * 100) / 100) + "$"
        }
    }
    
    var tokens: [TokenResult] = []
    var coins: Coins = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = walletName
        
        fetchCoinsIDs()
        
        fetchTokensFromAddress()
        
        self.tokensTableView.delegate = self
        self.tokensTableView.dataSource = self
        
        tokens.append(TokenResult(address: "qwe", balance: solBalance, info: TokenInfo(name: "Solana", symbol: "SOL", image: "https://s2.coinmarketcap.com/static/img/coins/64x64/5426.png")))
        
        walletAddressLabel.text = walletAddress
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelDidTap))
        tap.numberOfTapsRequired = 1
        walletAddressLabel.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segue = segue.destination as? NFTsViewController else { return }
        
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
//                self.tokens = self.tokens.sorted { $0.balance > $1.balance }
            }
        }.resume()
    }
    
    private func fetchCoinsIDs() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/list") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else { return }
            guard let coinsData = try? JSONDecoder().decode(Coins.self, from: data) else { return }
            DispatchQueue.main.async {
                self.coins = coinsData
            }
        }.resume()
    }
    
    // MARK: - Method for tap gesture
    @objc
    private func labelDidTap(sender: UITapGestureRecognizer) {
        let labelText = walletAddressLabel.text
        UIPasteboard.general.string = labelText
        let ac = UIAlertController(title: "Address copied", message: nil, preferredStyle: .alert)
        present(ac, animated: true)
        dismiss(animated: true)
    }
    
}
