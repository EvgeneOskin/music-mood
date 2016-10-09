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
    
    var eventGenerator: EventGenerator!
    let sampler = Sampler();
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        eventGenerator = EventGenerator(block: {
            frequency in
            self.sampler.change(frequency: frequency);
        })
        eventGenerator.start()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

