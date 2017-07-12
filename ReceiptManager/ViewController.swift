//
//  ViewController.swift
//  ReceiptManager
//
//  Created by non on 2016/10/10.
//  Copyright © 2016年 non. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet var receiptController: NSObjectController!
    var receiptForm: ReceiptForm!
    static let apiKey = ""
    static let directoryPath = "/Users/non/Desktop/receipt"
    var receipts: ReceiptList = ReceiptList(
        urls: directoryContents(directory: directoryPath).map { URL(fileURLWithPath: directoryPath + "/" + $0) },
        apiKey: apiKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waitUntilLoaded()
        loadAndPrefetch()
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        receipts.moveNext()
        loadAndPrefetch()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func waitUntilLoaded() {
        var wait = 0.5
        while(!self.receipts.loaded) {
            Thread.sleep(forTimeInterval: wait)
            wait = wait * 2
        }
    }
    
    func loadAndPrefetch() {
        if let receipt = receipts.getCurrent() {
            self.imageView.image = receipt.image
            if let text = receipt.text {
                self.receiptForm = ReceiptForm(receiptText: text)
                self.receiptController.content = self.receiptForm
            }
            receipts.prefetch()
        } else {
            // 終了処理
        }
    }
}

func directoryContents(directory: String) -> [String] {
    do {
        return try FileManager.default.contentsOfDirectory(atPath: directory)
    } catch {
        return []
    }
}
