//
//  AnnotatedText.swift
//  ReceiptManager
//
//  Created by non on 2016/11/23.
//  Copyright © 2016年 non. All rights reserved.
//

import Foundation

public class AnnotatedText : NSObject {
    var rect: [Point]
    dynamic var text: String?
    dynamic var category: String?
    var available : Bool
    private let sameThreshold = 10

    init(rect: [Point], text: String) {
        self.rect = rect
        self.text = text
        self.category = nil
        self.available = false
    }

    // テキスト領域の高さ中心か幅が閾値の範囲で一致していたら同じ行だと判断する
    func isSameCol(rval: AnnotatedText) -> Bool {
        let rvalCenter = (rval.rect[0].y + rval.rect[3].y)/2
        let lvalCenter = (self.rect[0].y + self.rect[3].y)/2
        let diff = abs(lvalCenter - rvalCenter)
        let rvalHeight = rval.rect[3].y - rval.rect[0].y
        let lvalHeight = self.rect[3].y - self.rect[0].y
        let heightDiff = abs(lvalHeight - rvalHeight)
        return diff <= sameThreshold && heightDiff <= sameThreshold
    }
}
