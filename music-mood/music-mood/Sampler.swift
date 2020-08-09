//
//  Sampler.swift
//  music-mood
//
//  Created by Eugene Oskin on 08.10.16.
//  Copyright © 2016 Eugene Oskin. All rights reserved.
//

import Foundation
import SwiftySound

class Sampler {
    var cooldown: Sound!
    var warmup: Sound!
    
    let warmupResource = "cafe.mp3"
    let cooldownResource = "rain.mp3"

    func modeScaleToFrequence(_ frequency: Float) -> Float {
        return exp(-pow(frequency / 50, 2));
    }
    
    init(warmupPath: String? = nil, cooldownPath: String? = nil) {
        guard let warmpupURL = Bundle.main.url(forResource: "cafe", withExtension: "mp3"),
            let cooldownURL = Bundle.main.url(forResource: "rain", withExtension: "mp3") else {
                return
        }
        warmup = Sound(url: warmpupURL)
        cooldown = Sound(url: cooldownURL)
        
        warmup.play(numberOfLoops: -1)
        cooldown.play(numberOfLoops: -1)
    }
    
    func change(frequency: Double) {
        let mode = modeScaleToFrequence(Float(frequency));
        cooldown.volume = 1 - mode;
        warmup.volume = mode;
    }
    
    func reset() {
        change(frequency: 0)
    }
    
    func setupTrack() {
        
    }
}
