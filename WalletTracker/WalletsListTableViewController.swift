//
//  WalletsListTableViewController.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 23.03.2023.
//

import UIKit

class WalletsListTableViewController: UITableViewController {
    
    // MARK: - Properties
    var wallets: [Result] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        self.navigationItem.leftBarButtonItem = editButtonItem
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
        
        let currentWallet = wallets[indexPath.row]
        
        cell.cellContentView.layer.cornerRadius = 15
        cell.walletAddressLabel.text = currentWallet.walletAddress
        cell.walletNameLabel.text = currentWallet.walletName
        cell.numberOfNFTsLabel.text = String(currentWallet.num_nfts)
        cell.numberOfSOLLabel.text = String(format: "%.2f", currentWallet.sol_balance)
        cell.numberOfTokensLabel.text = String(currentWallet.num_tokens)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wallets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func addButtonPressed() {
        presentAddAlertController(title: "Enter SOL address", message: nil, style: .alert) { walletAddress, walletName in
            self.fetchWalletData(address: walletAddress, name: walletName)
        }
    }
    
    
    // MARK: - Private Methods
    private func fetchWalletData(address: String, name: String) {
        guard let url = URL(string: "https://api.shyft.to/sol/v1/wallet/get_portfolio?network=mainnet-beta&wallet=\(address)") else { return }
        var request = URLRequest(url: url)
        request.addValue("-3iYNcRok7Gm4EMl", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            guard error == nil else { return }
            guard let walletData = try? JSONDecoder().decode(Wallet.self, from: data) else { return }
            DispatchQueue.main.async {
                if name != "" {
                    self.wallets.append(Result(walletName: name, walletAddress: address, sol_balance: walletData.result.sol_balance, num_tokens: walletData.result.num_tokens, num_nfts: walletData.result.num_nfts))
                } else {
                    self.wallets.append(Result(walletName: "Wallet \(self.wallets.count + 1)", walletAddress: address, sol_balance: walletData.result.sol_balance, num_tokens: walletData.result.num_tokens, num_nfts: walletData.result.num_nfts))
                }
                self.tableView.reloadData()
                print(self.wallets)
            }
        }.resume()
    }
    
}
