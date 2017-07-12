//
//  PaymentRecord.swift
//  ReceiptManager
//
//  Created by non on 2017/07/12.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

public struct PaymentRecord {
    let date: Date
    let price: Int
    let name: String
    let account: Account?
    
    func toJSON() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["date"] = date
        dictionary["price"] = price
        dictionary["name"] = name
        dictionary["account"] = account
        return dictionary
    }
}
