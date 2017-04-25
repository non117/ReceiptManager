//
//  AppDelegate.swift
//  ReceiptManager
//
//  Created by non on 2016/10/10.
//  Copyright © 2016年 non. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    override init() {
        ValueTransformer.setValueTransformer(CheckEmojiTransformer(), forName: NSValueTransformerName(rawValue: "CheckEmojiTransformer"))
        super.init()
    }


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

