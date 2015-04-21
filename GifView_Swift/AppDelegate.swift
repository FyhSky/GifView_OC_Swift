//
//  AppDelegate.swift
//  GifView_Swift
//
//  Created by SkyNullCode on 4/19/15.
//  Copyright (c) 2015 SkyNullCode. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var gifView:GifView!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        if(self.gifView != nil) {
            self.gifView.setImageURL("http://www.12306.cn/mormhweb/images/new02.gif")
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

