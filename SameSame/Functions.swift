//
//  Functions.swift
//  SameSame
//
//  Created by Bastiaan Nelissen on 02/01/16.
//  Copyright © 2016 Bastiaan Nelissen. All rights reserved.
//

import Foundation

let π = M_PI

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
