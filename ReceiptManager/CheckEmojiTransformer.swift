//
//  CheckEmojiTransformer.swift
//  ReceiptManager
//
//  Created by non on 2017/04/24.
//  Copyright © 2017年 non. All rights reserved.
//

import Foundation

@objc(CheckEmojiTransformer) class CheckEmojiTransformer : ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        return (value as? Bool).flatMap { $0 ? "💯" : "🙅" }
    }
}
