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
    var sampler: Sampler!
    
    var statusItem: NSStatusItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        updateFrequency(0)
        
        loadSampler()
        eventGenerator = EventGenerator(
            block: {
                frequency in
                self.sampler.change(frequency: frequency)
                self.updateFrequency(frequency)
            },
            reset: {
                self.sampler.reset()
                self.updateFrequency(0)
            }
        )
        eventGenerator.start()
    }
    
    func loadSampler() {
        sampler = Sampler();
    }
    func updateFrequency(_ frequency: Double) {
        statusItem.button?.title = String(format: "M %.0f", frequency)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

