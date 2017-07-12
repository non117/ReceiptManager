//
//  ReceiptList.swift
//  ReceiptManager
//
//  Created by non on 2017/04/26.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

public class ReceiptList {
    static let prefetchNum = 3
    var receipts: [Receipt]
    var currentIndex: Int = 0
    var loaded = false
    let client: OCRClient
    
    init(urls: [URL], apiKey: String) {
        self.receipts = urls.map { Receipt(imagePath: $0) }
        self.client = OCRClient(apiKey: apiKey)
        for index in 0..<(ReceiptList.prefetchNum + 1) {
            applyOcrByIndex(index: index)
        }
    }
    
    func getCurrent() -> Receipt? {
        if currentIndex < receipts.count {
            return receipts[currentIndex]
        }
        return nil
    }
    
    func moveNext() {
        self.currentIndex += 1
    }
    
    func prefetch() {
        applyOcrByIndex(index: currentIndex + ReceiptList.prefetchNum)
    }
    
    private func applyOcrByIndex(index: Int) {
        if index >= receipts.count { return }
        var receipt = receipts[index]
        DispatchQueue.global().async {
            self.client.annotate(imagePath: receipt.imagePath) {(res: AnnotatedResponse?) in
                if let response = res {
                    receipt.text = ReceiptText(response: response)
                    self.receipts[index] = receipt
                    self.loaded = true
                }
            }
        }
    }
}
