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
    let products: [Product]
    let date: Date?
    let store: String? = nil


    init(response: AnnotatedResponse) {
        // 1つめのTextは全行をconcatしたものなので落としておく
        let texts = response.toAnnotatedTexts().dropFirst().map { $0 }
        self.lines = TextConvertService.generateLines(texts: texts)
        self.date = self.lines.flatMap { $0.date }.first
        self.products = self.lines.flatMap { $0.product }
    }
}
