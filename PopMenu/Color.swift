//
//  Constants.swift
//  AudioTest
//
//  Created by Scott Krulcik on 2/20/15.
//  Copyright (c) 2015 Scott Krulcik. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    class func hexColor(hexstr:String)->UIColor{
        let scan = NSScanner(string: hexstr)
        var numerical:UInt32 = 0
        if scan.scanHexInt(&numerical){
            numerical &= 0xFFFFFF //mask out blank channel
            let red = CGFloat((numerical & 0xFF0000) >> 16)/255.0
            let green = CGFloat((numerical & 0x00FF00) >> 8)/255.0
            let blue = CGFloat(numerical & 0xFF)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        return whiteColor()
    }
}

struct ColorProfile {
    // Based off of Adobe Flat-UI-color-theme-2469224
    let primary = UIColor.hexColor("308272")
    let primaryDark = UIColor.hexColor("0E352E")
    let secondary = UIColor.hexColor("FFFFFF")
    let accent = UIColor.hexColor("681115")
    let accentDark = UIColor.hexColor("422622")
    let neutral = UIColor.hexColor("67889B")
}

let Color = ColorProfile()
