//
//  Sampler.swift
//  music-mood
//
//  Created by Eugene Oskin on 08.10.16.
//  Copyright © 2016 Eugene Oskin. All rights reserved.
//

import Foundation
import AudioKit


func resourcePlayer(resource: String) -> AKAudioPlayer {
    let fileUrl = Bundle.main.resourcePath
    let file = try! AKAudioFile(readFileName: resource, baseDir: AKAudioFile.BaseDirectory.resources)
    let player  = try! AKAudioPlayer(file: file)
    player.looping  = true
    return player
}

class Sampler {
    var mix: AKMixer!
    var cooldown: AKAudioPlayer!
    var warmup: AKAudioPlayer!
    
    let warmupResource = "cafe.mp3"
    let cooldownResource = "rain.mp3"

    func modeScaleToFrequence(_ frequency: Double) -> Double {
        return exp(-pow(frequency - 50, 2) / 50);
    }
    
    init() {
        cooldown = resourcePlayer(resource: cooldownResource)
        warmup = resourcePlayer(resource: warmupResource)
        mix =  AKMixer(cooldown, warmup)
        
        AudioKit.output = mix
        AudioKit.start()
        
        reset();
        cooldown.start();
        warmup.start();
    }
    
    func change(frequency: Double) {
        let mode = modeScaleToFrequence(frequency);
        warmup.volume = 1 - mode;
        cooldown.volume = mode;
    }
    
    func reset() {
        warmup.volume = 1;
        cooldown.volume = 0;
    }
    
    func setupTrack() {
        
    }
}
