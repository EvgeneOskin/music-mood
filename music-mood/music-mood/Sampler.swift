//
//  Sampler.swift
//  music-mood
//
//  Created by Eugene Oskin on 08.10.16.
//  Copyright © 2016 Eugene Oskin. All rights reserved.
//

import Foundation
import AudioKit


func instrument(noteNumber: Int, rate: Double, amplitude: Double) -> AKOperation {
    let metro = AKOperation.metronome(frequency: 82.0 / (60.0 * rate))
    let frequency = noteNumber.midiNoteToFrequency()
    return AKOperation.fmOscillator(baseFrequency: frequency, amplitude: amplitude)
        .triggeredWithEnvelope(trigger: metro, attack: 1.5, hold: 1, release: 0.5)
}

class Sampler {
    
    let generator = AKOperationGenerator() { _ in
        let instrument1 = instrument(noteNumber: 60, rate: 4, amplitude: 0.5)
        let instrument2 = instrument(noteNumber: 62, rate: 5, amplitude: 0.4)
        let instrument3 = instrument(noteNumber: 65, rate: 7, amplitude: 1.3/4.0)
        let instrument4 = instrument(noteNumber: 67, rate: 7, amplitude: 0.125)
        
        let instruments = (instrument1) * 0.13
        
        let reverb = instruments.reverberateWithCostello(feedback: 0.4, cutoffFrequency: 20000).toMono()
        
        let mix = mixer(instruments, reverb, balance: 0.4)
        return mix
    }
    
    init() {
        AudioKit.output = generator
        AudioKit.start()
        
        generator.start();
    }
}
