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
    var gevonden : Bool = false
    
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
        self.enabled = true // kaartje is klikbaar als hij naar boven ligt
        self.setImage(UIImage(named: "bb_achterkant" ), forState: .Normal)
        self.wiggle()
        print("achterkantje boven voor : \(self.naam)")
    }
    
    func voorkantBovenDraaien(){
        self.voorkantBoven = true
        self.enabled = false // kaartje is niet klikbaar als hij naar boven ligt
        self.setImage(UIImage(named: self.naam ), forState: .Normal)
        self.wiggle()
        print("voorkant boven voor: \(self.naam)")
    }

    func setjeGevonden(){
        self.gevonden = true
        UIView.animateWithDuration(0.6 ,
            animations: {
                self.transform = CGAffineTransformMakeScale(0.6, 0.6)
            },
            completion: { finish in
                UIView.animateWithDuration(0.6){
                    self.transform = CGAffineTransformIdentity
                    self.enabled = false
                    self.wiggle()
                    // afbeelding veranderen

                }
        })
        print("Setje gevonden voor: \(self.naam)")
    }
    
    func omdraaien()
    {
        // verzamel alle kaarten die open liggen
        variabelen.omgedraaideKaarten = []
        for i in variabelen.arrayMemoryKaarten where (i.voorkantBoven == true && i.gevonden == false){
            variabelen.omgedraaideKaarten += [i]
        }
        
        if variabelen.omgedraaideKaarten.count < variabelen.aantalSets {
            // maximaal aantal sets is nog niet omgedraaid
            print("\(variabelen.omgedraaideKaarten.count) van de \(variabelen.aantalSets) kaartjes omgedraaid. Nu wordt \(self.naam) omgedraaid.")
            // ben ik al omgedraaid?
            if self.voorkantBoven == true {
                print("\(self.naam) ligt met de voorkant naar boven, nu niets doen.")
            }else{
                print("\(self.naam) wordt nu omgedraaid.")
                self.voorkantBovenDraaien()
            }
        }

        // verzamel OPNIEUW alle kaarten die open liggen
        variabelen.omgedraaideKaarten = []
        for i in variabelen.arrayMemoryKaarten where (i.voorkantBoven == true && i.gevonden == false){
            variabelen.omgedraaideKaarten += [i]
        }
        
        if variabelen.omgedraaideKaarten.count == variabelen.aantalSets {
            // maximaal aantal sets is nog niet omgedraaid
            print("Er zijn \(variabelen.aantalSets) kaartjes omgedraaid. Eerst checken of er een setje is")
            
            // verzamel de 'namen' van de opengedraaide kaarten
            var kaartenOpengedraaid : [String] = []
            for i in variabelen.omgedraaideKaarten {
                kaartenOpengedraaid.append(i.naam)
            }
            // check hoeveel unieke kaarten er zijn gevonden, er zou een setje kunnen zijn.
            let uniekeVerzamelingOmgedraaideKaartjen = Array(Set(kaartenOpengedraaid))
            if uniekeVerzamelingOmgedraaideKaartjen.count == 1 {
                // setje gevonden
                print("Setje gevonden! \(uniekeVerzamelingOmgedraaideKaartjen.first)")
                for i in variabelen.omgedraaideKaarten {
                    i.setjeGevonden()
                }
            }else{
                // geen setje gevonden
                print("Geen setje gevonden, alles wordt teruggedraaid. Wel 1 moment laten liggen")
                var delayTime : Double = 0.9
                for i in variabelen.omgedraaideKaarten {
                    delay(delayTime) {
                        print("Kaartje: \(i.naam)")
                        i.gevonden = false
                        i.achterkantBovenDraaien()
                    }
                    delayTime = delayTime + delayTime
                }
            }
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
        // afbeelding niet standaard transparant maken bij 'disable' button
        self.adjustsImageWhenDisabled = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
