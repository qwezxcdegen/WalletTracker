//
//  UIImageView + Extension.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 25.03.2023.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL, completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completionHandler(true)
                    }
                }
            }
        }
    }
}
