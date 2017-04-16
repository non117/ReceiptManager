//
//  ReceiptForm.swift
//  ReceiptManager
//
//  Created by non on 2017/04/16.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

// viewへのbindingとvalidation, usecaseの窓口などの責務
// validationは分離してもよいかもしれない
public class ReceiptForm : NSObject {
    let items: [ItemForm]
    let sum: Int?
    let date: Date?

    init(receipt: Receipt) {
        self.items = receipt.items.map { ItemForm(item: $0) }
        self.sum = receipt.sumItem?.price
        self.date = receipt.date
    }
}
