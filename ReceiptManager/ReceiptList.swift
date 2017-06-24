//
//  ReceiptList.swift
//  ReceiptManager
//
//  Created by non on 2017/04/26.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

public class ReceiptList {
    var receipts: [Receipt]
    var currentIndex: Int = 0
    let client: OCRClient
    
    init(urls: [URL], apiKey: String) {
        self.receipts = urls.map { Receipt(imagePath: $0) }
        self.client = OCRClient(apiKey: apiKey)
    }
    
    func applyOcrByIndex(index: Int) {
        var receipt = receipts[index]
        DispatchQueue.global(qos: .default).async {
            self.client.annotate(imagePath: receipt.imagePath) {(res: AnnotatedResponse?) in
                if let response = res {
                    receipt.text = ReceiptText(response: response)
                    self.receipts[index] = receipt
                }
            }
        }
    }
}
