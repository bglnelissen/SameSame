//
//  MemorykaartClass.swift
//  SameSame
//
//  Created by Bastiaan Nelissen on 06/12/15.
//  Copyright © 2015 Bastiaan Nelissen. All rights reserved.
//

import Foundation
import UIKit
// import GameplayKit // nodig voor de array shuffle

class MemoryKaart : UIButton {
    let dek : Array<String>
    let id : Int
    let naam : String
    var voorkantBoven : Bool = false
    var found : Bool = false
    
    func wiggle(rotationRads : CGFloat = 0.0007 ) {
        var rotateDirection : CGFloat
        if 1 == arc4random_uniform(2) {
            rotateDirection = 1 * rotationRads * CGFloat(arc4random_uniform(100))
        }else{
            rotateDirection = -1 * rotationRads * CGFloat(arc4random_uniform(100))
        }
        self.transform = CGAffineTransformMakeRotation(rotateDirection)
    }
    
//    func setjeCheck(){
//        for memoryKaart in variabelen.arrayMemoryKaarten {
//            // tel het aantal kaarten dat open ligt
//            if memoryKaart.voorkantBoven {
//                variabelen.omgedraaideKaarten = variabelen.omgedraaideKaarten + [memoryKaart]
//            }
//        }
//        // er is een array met open kaarten (variabelen.omgedraaideKaarten)
//        
//        // als het juiste aantal is omgedraaid -> check voor een setje
//        if variabelen.omgedraaideKaarten.count == variabelen.aantalSets {
//
//            // beurt voorbij, reset de counter
//            variabelen.omgedraaideKaarten = []
//
//        }
//
//    }
    
    //        print("aantal kaartjes in de verzameling is nu: \(kaarten.count)")
    //        if kaarten.count == variabelen.aantalSets { // alle kaartjes voor deze beurt zijn omgedraaid
    //            let kaartjesUniek = Array(Set(kaarten))
    //            print("Aantal unieke in deze ronde: \(kaartjesUniek.count)")
    //            if kaartjesUniek.count == 1 {
    ////                let alert = UIAlertView()
    ////                alert.title = "SameSame"
    ////                alert.message = "Je hebt een setje gevonden: \(self.naam)"
    ////                alert.addButtonWithTitle("Oh yeah!")
    ////                alert.show()
    //                print("Setje gevonden!")
    //            }else{
    //                print("Jammer man, geen setje")
    //            }
    //        }
    
    func achterkantBovenDraaien() {
        self.voorkantBoven = false
        self.setImage(UIImage(named: "bb_achterkant" ), forState: .Normal)
        self.wiggle()
        print("achterkantje boven voor : \(self.naam)")
    }
    
    func voorkantBovenDraaien(){
        self.voorkantBoven = true
        self.setImage(UIImage(named: self.naam ), forState: .Normal)
        self.wiggle()
        print("voorkant boven voor: \(self.naam)")
    }
    
    func omdraaien()
    {
        // ga alle kaarten langs
        for memoryKaart in variabelen.arrayMemoryKaarten {
            // verzamel het aantal kaarten dat open ligt
            if memoryKaart.voorkantBoven {
                variabelen.omgedraaideKaarten = variabelen.omgedraaideKaarten + [memoryKaart]
            }
        }
        
        if variabelen.omgedraaideKaarten.count < variabelen.aantalSets {
            // maximaal aantal sets is nog niet omgedraaid
            print("Nog geen \(variabelen.aantalSets) kaartjes omgedraaid. Nu wordt \(self.naam) omgedraaid.")
        }
        if variabelen.omgedraaideKaarten.count >= variabelen.aantalSets {
            // maximaal aantal sets is nog niet omgedraaid
            print("Nog geen \(variabelen.aantalSets) kaartjes omgedraaid. Nu wordt \(self.naam) omgedraaid.")
        }
//            let uniekeVerzamelingOmgedraaideKaartjen = Array(Set(variabelen.omgedraaideKaarten))
//            if uniekeVerzamelingOmgedraaideKaartjen.count == 1 {
//                // setje gevonden
//                print("Setje gevonden! \(uniekeVerzamelingOmgedraaideKaartjen.first)")
//            }else{
//                // geen setje gevonden
//                print("Geen setje gevonden:")
//                for i in uniekeVerzamelingOmgedraaideKaartjen {
//                    i.omdraaien()
//                }
//                variabelen.omgedraaideKaarten = []
//            }
        }
        
//        if variabelen.omgedraaideKaarten.count == variabelen.aantalSets + 1 {
//            variabelen.omgedraaideKaarten = []
//            variabelen.omgedraaideKaarten = variabelen.omgedraaideKaarten + [self]
//        }
//        
//        // alleen een 'dicht' kaartje mag worden open gedraaid
//        if self.voorkantBoven == false {
//            self.voorkantBovenDraaien()
//        }
    
    }
    
    init(dek: Array<String>, id: Int, coordinaten: CGRect){
        self.dek = dek
        self.id = id
        self.naam = dek[id]
        // self.voorkantBoven = false
        
        // super init is nodig omdat we erven van UIButton
        super.init(frame: coordinaten)
        
        // begin status van alle kaartjes
        self.setImage(UIImage(named: "bb_achterkant" ), forState: .Normal)
        self.setTitle(self.naam, forState: .Normal)
        self.wiggle()
        self.addTarget(self, action:"omdraaien", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
