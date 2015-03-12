//
//  ComponentTests.swift
//  PopMenu
//
//  Created by Scott Krulcik on 3/9/15.
//  Copyright (c) 2015 Scott Krulcik. All rights reserved.
//

import Foundation
import UIKit

func testCircles(testController:UIViewController){
    let f = testController.view.frame
    let b1Frame = CGRect(x: 0,      y: 0,         width: f.maxX/2, height: f.maxY/3)
    let b2Frame = CGRect(x: f.midX, y: 0,         width: f.maxX/2, height: f.maxY/3)
    let b3Frame = CGRect(x: 0,      y: f.maxY/3,  width: f.maxX/2, height: f.maxY/3)
    let b4Frame = CGRect(x: f.midX, y: f.maxY/3,  width: f.maxX/2, height: f.maxY/3)
    let b5Frame = CGRect(x: 0,      y: 2*f.maxY/3,width: f.maxX/2, height: f.maxY/3)
    let b6Frame = CGRect(x: f.midX, y: 2*f.maxY/3,width: f.maxX/2, height: f.maxY/3)
    let b1 = CircleView(frame: b1Frame, withCenter: .NW)
    //b1.backgroundColor = UIColor.redColor()
    testController.view.addSubview(b1)
    let b2 = CircleView(frame: b2Frame, withCenter: .NE)
    b2.arcColor = UIColor.blueColor()
    testController.view.addSubview(b2)
    let b3 = CircleView(frame: b3Frame, withCenter: .W)
    b3.arcColor = UIColor.orangeColor()
    testController.view.addSubview(b3)
    let b4 = CircleView(frame: b4Frame, withCenter: .E)
    b4.arcColor = UIColor.purpleColor()
    testController.view.addSubview(b4)
    let b5 = CircleView(frame: b5Frame, withCenter: .SW)
    b5.arcColor = UIColor.yellowColor()
    testController.view.addSubview(b5)
    let b6 = CircleView(frame: b6Frame, withCenter: .SE)
    b6.arcColor = UIColor.blackColor()
    testController.view.addSubview(b6)
}

//func testPopcornButtons(testController:UIViewController){
//    let f = testController.view.frame
//    
//    let b1Frame = CGRect(x: 0,      y: 0, width: f.maxX/2, height: f.maxY/3)
//    let b1Range = AngleRange(start:3.0, end: 2.0, range:nil)
//    let b1Circ = Circle(radius:b1Frame.width/2, center:CGPoint(x: b1Frame.maxX/2, y: b1Frame.maxY/2))
////    let b2Frame = CGRect(x: f.midX, y: 0, width: f.maxX/2, height: f.maxY/3)
////    let b2Range = AngleRange(start:PI/2, end: 4*PI/3, range:nil)
////    let b2Circ = Circle(radius:100, center:CGPoint(x: 3*f.midX/2, y: f.midY/2))
//    
//    let b1 = PopcornButton(frame: b1Frame, circle: b1Circ, range: b1Range)
//    b1.backgroundColor = UIColor.clearColor()
//    testController.view.addSubview(b1)
////    let b2 = PopcornButton(frame: b1Frame, circle: b2Circ, range: b2Range)
////    testController.view.addSubview(b2)
//}
