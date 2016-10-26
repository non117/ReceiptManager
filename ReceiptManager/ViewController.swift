//
//  ViewController.swift
//  ReceiptManager
//
//  Created by non on 2016/10/10.
//  Copyright © 2016年 non. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let key = ""
        let path = "/Users/non/Desktop/IMG_3294.JPG"
        let url = NSURL.fileURL(withPath: path)
        let client = OCRClient(apiKey: key)
        let res = client.annotate(imagePath: url)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

