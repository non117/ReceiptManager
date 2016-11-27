//
//  Receipt.swift
//  ReceiptManager
//
//  Created by non on 2016/11/27.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

public struct Receipt {
    let texts: [AnnotatedText]
    let customer: String?
    let date: Date?

    init(texts: [AnnotatedText]) {
        self.texts = texts
        self.customer = nil
        self.date = nil
    }
}
