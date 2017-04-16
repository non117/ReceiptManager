//
//  Item.swift
//  ReceiptManager
//
//  Created by non on 2017/04/03.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

public struct Item {
    let price: Int
    let name: String
    var valid: Bool
    let account: Account? = nil
    private let sumKeywords = ["合計"]
    public func isSum() -> Bool {
        return sumKeywords.map(name.contains).contains(true)
    }
    public func check() -> Item {
        return Item(price: price, name: name, valid: !valid)
    }
}
