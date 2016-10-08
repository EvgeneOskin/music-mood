//
//  AppDelegate.swift
//  music-mood
//
//  Created by Eugene Oskin on 08.10.16.
//  Copyright © 2016 Eugene Oskin. All rights reserved.
//

import Cocoa
import AppKit;


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem!
    var eventGenerator = EventGenerator();
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        statusItem.button?.title = "M"
        eventGenerator.start()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

