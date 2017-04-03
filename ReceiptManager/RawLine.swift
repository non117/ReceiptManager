//
//  RawLine.swift
//  ReceiptManager
//
//  Created by non on 2016/12/18.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

public struct RawLine {
    let texts: [RawText]
    let words: [String]
    private let priceSymbols = ["円", "￥"]
    
    init(texts: [RawText]) {
        self.texts = texts
        self.words = TextConvertService.splitToWords(texts: texts)
    }
    
    // price, product, date, storeプロパティ, nilをかえすことも, maybeであるべき？

    
    func includesPrice() {
        
    }
    
    func includesDate() {
        
    }
    // そのうち店の名前判定を辞書をもとにおこないたい
}
