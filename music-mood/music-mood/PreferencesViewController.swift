//
//  PreferencesViewController.swift
//  music-mood
//
//  Created by Eugene Oskin on 09.10.16.
//  Copyright © 2016 Eugene Oskin. All rights reserved.
//

import Foundation
import Cocoa

class PreferencesViewController: NSViewController {

    @IBOutlet weak var warmup: NSTextField!
    @IBOutlet weak var cooldown: NSTextField!
    
    @IBAction func save(_ sender: AnyObject) {
        let warmUpUrl = warmup.stringValue
        let coolDownUrl = warmup.stringValue        
    }
}
