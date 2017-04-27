//
//  ReceiptList.swift
//  ReceiptManager
//
//  Created by non on 2017/04/26.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

public struct ReceiptList {
    let receipts: [Receipt]
    let currentIndex: Int = 0
    let client: OCRClient
    
    init(urls: [URL], apiKey: String) {
        self.receipts = urls.map { Receipt(imagePath: $0) }
        self.client = OCRClient(apiKey: apiKey)
    }
    }
}
