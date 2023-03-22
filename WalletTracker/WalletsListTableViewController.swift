//
//  WalletsListTableViewController.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 23.03.2023.
//

import UIKit

class WalletsListTableViewController: UITableViewController {
    
    var wallets: [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        wallets.append(Result(balance: 12))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wallets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath) as! WalletTableViewCell
        
//        cell.walletAddressLabel.text = wallets[indexPath.row].address
        cell.walletBalanceLabel.text = String(wallets[indexPath.row].balance)
        

        return cell
    }
    
    @IBAction func addButtonPressed() {
        presentAddAlertController(title: "Enter SOL address", message: nil, style: .alert) { walletAddress in
            self.fetchWalletData(address: walletAddress)
        }
    }
    
    
    private func fetchWalletData(address: String) {
        guard let url = URL(string: "https://api.shyft.to/sol/v1/wallet/balance?network=mainnet-beta&wallet=\(address)") else { return }
        var request = URLRequest(url: url)
        request.addValue("-3iYNcRok7Gm4EMl", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            guard error == nil else { return }
            guard let walletData = try? JSONDecoder().decode(Wallet.self, from: data) else { return }
            DispatchQueue.main.async {
                self.wallets.append(Result(balance: walletData.result.balance))
                self.tableView.reloadData()
                print(self.wallets)
            }
        }.resume()
    }
    
}
