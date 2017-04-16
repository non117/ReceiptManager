//
//  Receipt.swift
//  ReceiptManager
//
//  Created by non on 2016/11/27.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

public struct Receipt {
    let lines: [RawLine]
    let items: [Item]
    let sumItem: Item?
    let date: Date?
    let store: String? = nil
    static let TAX_RATE = 1.08 // FIXME: move to constants

    init(response: AnnotatedResponse) {
        // 1つめのTextは全行をconcatしたものなので落としておく
        let texts = response.toAnnotatedTexts().dropFirst().map { $0 }
        self.lines = TextConvertService.generateLines(texts: texts)
        self.date = self.lines.flatMap { $0.date }.first
        let items = self.lines.flatMap { $0.item }
        self.sumItem = items.filter { $0.isSum() }.first
        if let sum = sumItem?.price {
            self.items = Receipt.checkItems(items: items, sum: sum)
        } else {
            self.items = items
        }
    }
    
    // itemsを上から見ていって合計額がsumと一致するかどうか
    // しない場合は税抜価格の可能性があるので税率をかけてみる
    private static func checkItems(items: [Item], sum: Int) -> [Item] {
        var excludeTaxSum = 0
        var includeTaxSum = 0
        return items.map{ (item: Item) -> Item in
            // 内税表示と一致するか、外税表示で足しても合計額より超えそうだったらcheckをやめる
            if excludeTaxSum >= sum || includeTaxSum == sum {
                return item
            } else {
                includeTaxSum += item.price
                excludeTaxSum += Int(round(Receipt.TAX_RATE * Double(item.price)))
                return item.check()
            }
        }
    }
}
