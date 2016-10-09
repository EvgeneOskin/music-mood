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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        loadSampler()
        eventGenerator = EventGenerator(
            block: {frequency in self.sampler.change(frequency: frequency)},
            reset: {self.sampler.reset()})
        eventGenerator.start()
    }
    
    func loadSampler() {
        sampler = Sampler();
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

