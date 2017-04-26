//
//  ReceiptList.swift
//  ReceiptManager
//
//  Created by non on 2017/04/26.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

public struct ReceiptList {
    let images: [ReceiptImage]
    let receipts: [Receipt] = []
    let currentIndex: Int = 0
    
    init(urls: [URL]) {
        self.images = urls.map { ReceiptImage(path: $0) }        
    }
}
