//
//  AnnotatedText.swift
//  ReceiptManager
//
//  Created by non on 2016/11/23.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

// なまえをかえたいRawTextとかに
public struct AnnotatedText {
    let rect: [Point]
    let text: String
    
    var horizontalPosition: Int {
        get {
            return (self.rect[0].y + self.rect[3].y) / 2
        }
    }
    var fontWidth: Int {
        get {
            let width = rect[1].x - rect[0].x
            let num = text.characters.count
            return width / num
        }
    }
    var fontHeight: Int {
        get {
            return rect[3].y - rect[0].y
        }
    }

    init(rect: [Point], text: String) {
        self.rect = rect
        self.text = text
    }
    public func isSameLine(rval: AnnotatedText) -> Bool {
        let minFontHeight = min(rval.fontHeight, self.fontHeight)
        return abs(rval.horizontalPosition - self.horizontalPosition) <= minFontHeight
    }
}
