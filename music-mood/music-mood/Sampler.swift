//
//  Sampler.swift
//  music-mood
//
//  Created by Eugene Oskin on 08.10.16.
//  Copyright © 2016 Eugene Oskin. All rights reserved.
//

import Foundation
import AudioKit

func instrument(noteNumber: Int, rate: AKParameter, amplitude: AKParameter) -> AKOperation {
    let metro = AKOperation.metronome(frequency: 82.0 / (60.0 * rate))
    let frequency = noteNumber.midiNoteToFrequency()
    return AKOperation.fmOscillator(baseFrequency: frequency, amplitude: amplitude)
        .triggeredWithEnvelope(trigger: metro, attack: 1.5, hold: 1, release: 0.5)
}

class Sampler {
    
    let generator = AKOperationGenerator() { parameters in
        let multiply = parameters[0]
        
        let instrument1 = instrument(noteNumber: 60, rate: 4 * multiply, amplitude: 0.5)
        let instrument2 = instrument(noteNumber: 62, rate: 5 * multiply, amplitude: 0.4)
        let instrument3 = instrument(noteNumber: 65, rate: 7 * multiply, amplitude: 1.3 / 4.0)
        let instrument4 = instrument(noteNumber: 67, rate: 7 * multiply, amplitude: 0.125)
        let chaos = AKOperation.whiteNoise() * 0.05 / multiply;
        
        let instruments = (chaos + instrument1 + instrument2 + instrument3 + instrument4) * 0.13
        
        let reverb = instruments.reverberateWithCostello(feedback: 0.8, cutoffFrequency: 5000).toMono()
        
        let mix = mixer(instruments, reverb, balance: 0.4)
        return mix
    }
    
    init() {
        AudioKit.output = generator
        AudioKit.start()
        
        reset();
        generator.start();
    }
    
    func change(frequency: Double) {
        generator.parameters[0] = frequency;
    }
    
    func reset() {
        generator.parameters[0] = 1;
    }
}
