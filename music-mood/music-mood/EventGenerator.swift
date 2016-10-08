//
//  EventGenerator.swift
//  music-mood
//
//  Created by Eugene Oskin on 08.10.16.
//  Copyright © 2016 Eugene Oskin. All rights reserved.
//

import Cocoa

class EventGenerator {
    
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
    
    func start() {
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
    
}
