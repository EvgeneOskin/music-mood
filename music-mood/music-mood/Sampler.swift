//
//  Sampler.swift
//  music-mood
//
//  Created by Eugene Oskin on 08.10.16.
//  Copyright © 2016 Eugene Oskin. All rights reserved.
//

import Foundation
import AudioKit


func resourcePlayer(_ resource: String) -> AKAudioPlayer {
    let file = try! AKAudioFile(
        readFileName: resource,
        baseDir: AKAudioFile.BaseDirectory.resources
    )
    let player  = try! AKAudioPlayer(file: file)
    player.looping  = true
    return player
}

func filePlayer(_ path: String) throws -> AKAudioPlayer  {
    let pathURL = URL(fileURLWithPath: path, isDirectory: false)
    let file = try AKAudioFile(forReading: pathURL)
    let player  = try AKAudioPlayer(file: file)
    player.looping  = true
    return player
}

func loadFilePlayer(_ path: String? = nil, fallbackResource: String) -> AKAudioPlayer {
    do {
        if path != nil {
            return try filePlayer(path!)
        } else {
            return resourcePlayer(fallbackResource)
        }
    } catch {
        return resourcePlayer(fallbackResource)
    }
}

class Sampler {
    var mix: AKMixer!
    var cooldown: AKAudioPlayer!
    var warmup: AKAudioPlayer!
    
    let warmupResource = "cafe.mp3"
    let cooldownResource = "rain.mp3"

    func modeScaleToFrequence(_ frequency: Double) -> Double {
        return exp(-pow(frequency / 30, 2));
    }
    
    init(warmupPath: String? = nil, cooldownPath: String? = nil) {
        warmup = loadFilePlayer(warmupPath, fallbackResource: warmupResource)
        cooldown = loadFilePlayer(cooldownPath, fallbackResource: cooldownResource)
        
        mix = AKMixer(cooldown, warmup)
        
        AudioKit.output = mix
        AudioKit.start()
        
        reset();
        cooldown.start();
        warmup.start();
    }
    
    func change(frequency: Double) {
        let mode = modeScaleToFrequence(frequency);
        cooldown.volume = 1 - mode;
        warmup.volume = mode;
    }
    
    func reset() {
        change(frequency: 0)
    }
    
    func setupTrack() {
        
    }
}
