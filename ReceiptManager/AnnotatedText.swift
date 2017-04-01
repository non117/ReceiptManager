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
    private let sameThreshold = 10
    
    var y: Int {
        get {
            return (self.rect[0].y + self.rect[3].y) / 2
        }
    }
    var fontSize: Int {
        get {
            let width = rect[1].x - rect[0].x
            let num = text.characters.count
            return width / num
        }
    }

    init(rect: [Point], text: String) {
        self.rect = rect
        self.text = text
    }

    // テキスト領域の高さ中心が閾値の範囲で一致していたら同じ行だと判断する
    func isSameLine(rval: AnnotatedText) -> Bool {
        return abs(rval.y - self.y) <= sameThreshold
    }
}
