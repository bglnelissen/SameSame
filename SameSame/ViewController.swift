//
//  ViewController.swift
//  SameSame
//
//  Created by Bastiaan Nelissen on 06/12/15.
//  Copyright © 2015 Bastiaan Nelissen. All rights reserved.
//

import UIKit
import GameKit

struct variabelen {
    // as found on: http://stackoverflow.com/a/26195727
    
    // Settings
    static var aantalSets : Int = 2
    static let minimaleKaartAfstand : CGFloat = 0.04 // minimal card margin
    // static let memoryKaarten : [String] = ["bb_aanbeeld", "bb_asjemenou", "bb_boor", "bb_cadeautje", "bb_flex", "bb_gaatjestang", "bb_hamer", "bb_handboor", "bb_ladder", "bb_motorzaag", "bb_passer", "bb_plant", "bb_schaar", "bb_snor", "bb_veiligheidsspeld", "bb_verven", "bb_zaklamp"]
    static let memoryKaarten : [String] = ["bb_aanbeeld", "bb_asjemenou", "bb_boor"]

    static var arrayMemoryKaarten:[MemoryKaart] = []
    static var omgedraaideKaarten:[MemoryKaart] = []
}

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Schudden
        let randomSeed : UInt64 =  1 // UInt64(arc4random_uniform(1337)) // random int 1337
        
        var memoryKaartenSet : [String] = [] // lege set met kaarten
        for _ in 1...variabelen.aantalSets {
            memoryKaartenSet = memoryKaartenSet + variabelen.memoryKaarten // x aantal sets met kaarten
        }
        // TODO shut de set met de randomSeed
        let lcg = GKLinearCongruentialRandomSource(seed: randomSeed)
        let memoryKaartenGeschut = lcg.arrayByShufflingObjectsInArray(memoryKaartenSet) as! Array<String>
        
        // Uitrekenen hoe de kaarten te verdelen over de rijen en kolommen
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenSurface :CGFloat = screenSize.width * screenSize.height
        let ratio :CGFloat = sqrt(CGFloat(memoryKaartenGeschut.count)/CGFloat(screenSurface))
        var aantalKolommen = Int(floor(screenSize.width * ratio))
        var aantalRijen = Int(floor(screenSize.height * ratio))
        let oppervlakteGeschat = aantalKolommen * aantalRijen
        let overgeblevenMemoryKaarten :Int = Int(memoryKaartenGeschut.count) - Int(oppervlakteGeschat)
        if overgeblevenMemoryKaarten < aantalRijen { // we need only 1 more column
            aantalKolommen += 1
        } else if overgeblevenMemoryKaarten < aantalKolommen { // we need only one more row
            aantalRijen += 1
        } else { // we need more than row + column
            aantalKolommen += 1
            aantalRijen += 1
        }
        
        // debug
        print("Totaal aantal kaarten: \(memoryKaartenGeschut.count)")
        print("Aantal kolommen: \(aantalKolommen)")
        print("Aantal rijen: \(aantalRijen)")
        print("Random seed: \(randomSeed)")
        
        // Kaarten over het scherm verdelen
        
        // ruimte die nodig is per kaart, inclusief 'margin'
        let kaartBreedte = (screenSize.width / CGFloat(aantalKolommen))
        let kaartHoogte = (screenSize.height / CGFloat(aantalRijen))
        
        // Afstand ('margin') uitrekenen tussen de kaarten
        var kaartAfstandBreedte :CGFloat
        var kaartAfstandHoogte :CGFloat
        var kaartSizeHoogte :CGFloat
        var kaartSizeBreedte :CGFloat
        if kaartBreedte >= kaartHoogte { // cards are more jamned in height
            kaartAfstandHoogte = 2 * (kaartHoogte * variabelen.minimaleKaartAfstand) //margin is the total (top + bottom) margin
            kaartSizeHoogte = kaartHoogte - kaartAfstandHoogte
            kaartSizeBreedte = kaartSizeHoogte // square sized cards
            kaartAfstandBreedte = kaartBreedte - kaartSizeBreedte
        } else { // cards are more jamned in width
            kaartAfstandBreedte = 2 * (kaartBreedte * variabelen.minimaleKaartAfstand) //margin is the total (left + right) margin
            kaartSizeBreedte = kaartBreedte - kaartAfstandBreedte
            kaartSizeHoogte = kaartSizeBreedte // square sized cards
            kaartAfstandHoogte = kaartHoogte - kaartSizeHoogte
        }
        
        // Kaarten verdelen over het scherm
        var i = 0;
        // by rows by column
        for row in 0...(aantalRijen - 1) {
            for column in 0...(aantalKolommen - 1) {
                // get coordinates, shift half a margin to get it free from border
                let xCoordinaat :CGFloat = CGFloat(kaartAfstandBreedte/2) + (kaartBreedte * CGFloat(column))
                let yCoordinaat :CGFloat = CGFloat(kaartAfstandHoogte/2) + (kaartHoogte * CGFloat(row))
                // zolang er kaartjes zijn, blijven neerleggen
                if i < memoryKaartenGeschut.count {
                    let memoryKaartje = MemoryKaart(dek: memoryKaartenGeschut, id: i, coordinaten: CGRect(x: xCoordinaat, y:yCoordinaat, width: kaartSizeBreedte, height: kaartSizeHoogte))
                    variabelen.arrayMemoryKaarten += [memoryKaartje]
                }
                i = i + 1 // ittereer door de kaartjes
            }
        }
        
        // Voeg de array van buttons toe aan het scherm
        for memoryKaart in variabelen.arrayMemoryKaarten {
            self.view.addSubview(memoryKaart)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


