//
//  ReceiptImage.swift
//  ReceiptManager
//
//  Created by non on 2017/04/26.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation
import Cocoa

public struct ReceiptImage {
    public let path: URL
    
    init(path: URL) {
        self.path = path
    }
    
    var image: NSImage? {
        get {
            return NSImage(contentsOf: path)
        }
    }
}
