//
//  Receipt.swift
//  ReceiptManager
//
//  Created by non on 2017/04/27.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation
import Cocoa

public struct Receipt {
    public var text: ReceiptText? = nil
    public let imagePath: URL
    
    init(imagePath: URL) {
        self.imagePath = imagePath
    }
    
    var image: NSImage? {
        get {
            return NSImage(contentsOf: imagePath)
        }
    }
}
