//
//  ItemForm.swift
//  ReceiptManager
//
//  Created by non on 2017/04/16.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

public class ItemForm : NSObject {
    let price: Int
    let name: String
    let valid: Bool
    let account: Account?
    init(item: Item) {
        self.price = item.price
        self.name = item.name
        self.valid = item.valid
        self.account = nil
    }
}
