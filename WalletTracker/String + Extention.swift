//
//  String + Extention.swift
//  WalletTracker
//
//  Created by Степан Фоминцев on 25.03.2023.
//

import Foundation

extension String {
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
