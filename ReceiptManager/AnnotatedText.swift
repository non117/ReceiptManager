//
//  AnnotatedText.swift
//  ReceiptManager
//
//  Created by non on 2016/11/23.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

// なまえをかえたいRawTextとかに
public struct AnnotatedText {
    let rect: [Point]
    let text: String
    let isPrice: Bool
    private let sameThreshold = 10
    private let priceSymbols = ["円", "￥"]
    
    var y: Int {
        get {
            return (self.rect[0].y + self.rect[3].y) / 2
        }
    }

    init(rect: [Point], text: String) {
        self.rect = rect
        self.text = text
        self.isPrice = self.priceSymbols.map{ text.contains($0) }.contains(true)
    }

    // テキスト領域の高さ中心が閾値の範囲で一致していたら同じ行だと判断する
    func isSameLine(rval: AnnotatedText) -> Bool {
        return abs(rval.y - self.y) <= sameThreshold
    }
}
