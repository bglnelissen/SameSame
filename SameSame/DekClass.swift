//
//  KaartendekClass.swift
//  SameSame
//
//  Created by Bastiaan Nelissen on 24/12/15.
//  Copyright © 2015 Bastiaan Nelissen. All rights reserved.
//

import Foundation

class Dek {
    let dek : Array<String>
    let seed : Int
    
    var memoryKaartenSet : [String] = [] // lege set met kaarten
    for _ in 1...bb.aantalSets {
    memoryKaartenSet = memoryKaartenSet + bb.memoryKaarten // x aantal sets met kaarten
    }
    // TODO shut de set met de randomSeed
    let lcg = GKLinearCongruentialRandomSource(seed: randomSeed)
    let memoryKaartenGeschut = lcg.arrayByShufflingObjectsInArray(memoryKaartenSet) as! Array<String>
    
    
    
    
    init(kaarten: Array<String>, sets: Int, seed: Int ){
        // leeg dek met memory kaarten maken
        var dek : [Memorykaart] = []
        
        
    }
}