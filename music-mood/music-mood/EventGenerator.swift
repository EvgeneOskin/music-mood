//
//  EventGenerator.swift
//  music-mood
//
//  Created by Eugene Oskin on 08.10.16.
//  Copyright © 2016 Eugene Oskin. All rights reserved.
//

import Cocoa

class EventGenerator {
    
    var timer: Timer!
    let firePeriodSeconds: TimeInterval = 2
    
    var resetCounterTimer: Timer!
    let resetdSeconds: TimeInterval = 10
    
    let mask = NSEvent.EventTypeMask.keyDown
        .union(NSEvent.EventTypeMask.keyUp)
        .union(NSEvent.EventTypeMask.mouseMoved)
        .union(NSEvent.EventTypeMask.leftMouseDown)
        .union(NSEvent.EventTypeMask.leftMouseUp)
        .union(NSEvent.EventTypeMask.leftMouseDragged)
        .union(NSEvent.EventTypeMask.rightMouseDown)
        .union(NSEvent.EventTypeMask.rightMouseUp)
        .union(NSEvent.EventTypeMask.rightMouseDragged)
        .union(NSEvent.EventTypeMask.scrollWheel);
    
    let changeBlock: (_: Double) -> ()
    let resetBlock: () -> ()
    let counter = Counter()
    
    init(block: @escaping (_: Double) -> (), reset: @escaping () -> ()) {
        self.changeBlock = block
        self.resetBlock = reset
    }
    func start() {
        NSEvent.addGlobalMonitorForEvents(matching: mask)
            { (event: NSEvent) in self.handleEvent(event: event)}
        NSEvent.addLocalMonitorForEvents(matching: mask)
            { (event: NSEvent) in self.handleEvent(event: event)}
        
        timer = Timer.scheduledTimer(
            timeInterval: firePeriodSeconds,
            target: self, selector: #selector(refire),
            userInfo: nil, repeats: true
        )
        resetCounterTimer = Timer.scheduledTimer(
            timeInterval: resetdSeconds,
            target: self, selector: #selector(reset),
            userInfo: nil, repeats: true
        )
    }
    
    func handleEvent(event: NSEvent) -> NSEvent {
        counter.add();
        return event;
    }
    
    @objc func refire() {
        counter.tick(deltaSeconds: firePeriodSeconds)
        if (counter.value != 0) {
            self.changeBlock(counter.frequency)
        } else {
            self.resetBlock()
        }
    }
    
    @objc func reset(){
        counter.reset()
    }
}

class Counter {
    var value: Double = 0;
    var elapsedSeconds: Double = 0;
    
    var frequency : Double {
        get {
            return value / elapsedSeconds
        }
    }
    
    func add() {
        value += 1
    }
    func tick(deltaSeconds: Double) {
        elapsedSeconds += deltaSeconds
    }
    
    func reset() {
        value = 0
        elapsedSeconds = 0;
    }
    
}
