//
//  UILabel + Extension.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 26.03.2023.
//

import Foundation
import UIKit

extension UILabel {
    func getCurrencyPrice(id: String, cell: TokenTableViewCell, completionHandler: @escaping (Double) -> Void) {
        print("1")
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=\(id)&vs_currencies=usd") else { return }
            print(url)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            print("2")
            URLSession.shared.dataTask(with: request) { data, response, error in
                print("3")
                guard let data, error == nil else { return }
                print("pre 4")
                guard let data = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                print("4")
                DispatchQueue.main.async {
                    print("5")
                    guard let data = data[id] as? [String: Double] else { return }
                    var price = data[data.keys.first!] ?? 0.0
                    price = round(price * 100000) / 100000
                    guard let amount = Double(cell.tokenAmountLabel.text!) else { return }
                    var totalPrice = amount * price
                    totalPrice = round(totalPrice * 1000) / 1000
                    self?.text = "\(totalPrice)$"
                    completionHandler(totalPrice)
                }
            }.resume()
        }
    }
}
