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

    override func viewDidLoad() {
        super.viewDidLoad()

        let imagePath = URL(fileURLWithPath: "/Users/non/Desktop/IMG_0001.JPG")
        self.imageView.image = NSImage(contentsOf: imagePath)
        
        //let client = OCRClient(apiKey: "")
        //client.annotate(imagePath: imagePath, responseHandler: {(res: AnnotatedResponse?) in
        //    print(res)
        //})
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

