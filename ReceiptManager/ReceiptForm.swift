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
    dynamic var sumIsValid = false
    dynamic var estimatedSum = 0
    dynamic var checkedSum = 0
    let date: Date?

    init(receipt: Receipt) {
        self.items = receipt.items.map { ItemForm(item: $0) }
        if let sumItem = receipt.sumItem {
            self.estimatedSum = sumItem.price
        }
        self.date = receipt.date
        super.init()
        checkSum()
        // itemsの監視など
        items.forEach {
            $0.addObserver(self, forKeyPath: "valid", context: nil)
            $0.addObserver(self, forKeyPath: "price", context: nil)
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "valid")
        self.removeObserver(self, forKeyPath: "price")
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        checkSum()
    }
    
    func checkSum() {
        checkedSum = items.filter{ $0.valid }.map{ $0.price }.reduce(0, +)
        if (estimatedSum == 0 || checkedSum == 0) {
            sumIsValid = false
        } else {
            sumIsValid = estimatedSum == checkedSum
        }
    }
}
