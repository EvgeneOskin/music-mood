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
    var statusButton: NSStatusBarButton!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        var height = NSStatusBar.system().thickness
        statusButton = NSStatusBarButton()
        statusButton.title = "mood"
        statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        statusItem.button = statusButton;
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

