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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testDataLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private func testDataLoad() {
        let imagePath = URL(fileURLWithPath: "/Users/non/Desktop/IMG_0001.JPG")
        self.imageView.image = NSImage(contentsOf: imagePath)
        
        //let client = OCRClient(apiKey: "")
        //client.annotate(imagePath: imagePath, responseHandler: {(res: AnnotatedResponse?) in
        //    let receipt = Receipt(response: res!)
        //    self.receiptForm = ReceiptForm(receipt: receipt)
        //    self.receiptController.content = self.receiptForm
        //})
        let testJson = URL(fileURLWithPath: "/Users/non/Desktop/working/res.json")
        guard let res = try? Data(contentsOf: testJson) else {
            return
        }
        let jsonData = try? JSONSerialization.jsonObject(with: res)
        guard let annotatedResponse = try? AnnotatedResponse.decodeValue(jsonData) else {
            return
        }
        let receipt = Receipt(response: annotatedResponse)
        self.receiptForm = ReceiptForm(receipt: receipt)
        self.receiptController.content = self.receiptForm
    }
}

