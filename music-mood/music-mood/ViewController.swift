//
//  ViewController.swift
//  music-mood
//
//  Created by Eugene Oskin on 08.10.16.
//  Copyright © 2016 Eugene Oskin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    let mask = NSEventMask.keyDown
        .union(NSEventMask.keyUp)
        .union(NSEventMask.mouseMoved)
        .union(NSEventMask.leftMouseDown)
        .union(NSEventMask.leftMouseUp)
        .union(NSEventMask.leftMouseDragged)
        .union(NSEventMask.rightMouseDown)
        .union(NSEventMask.rightMouseUp)
        .union(NSEventMask.rightMouseDragged)
        .union(NSEventMask.scrollWheel);
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSEvent.addGlobalMonitorForEvents(matching: mask, handler:
            { (event: NSEvent) in self.handleEvent(event: event)}
        )
        NSEvent.addLocalMonitorForEvents(matching: mask, handler:
            { (event: NSEvent) in self.handleEvent(event: event)}
        )
    }

    func handleEvent(event: NSEvent) -> NSEvent {
        NSBeep();
        return event;
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

