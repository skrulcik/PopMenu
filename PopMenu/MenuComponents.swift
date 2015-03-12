//
//  MenuComponents.swift
//  PopMenu
//
//  Created by Scott Krulcik on 3/9/15.
//  Copyright (c) 2015 Scott Krulcik. All rights reserved.
//

import Foundation
import UIKit

//
//protocol PopcornMenuViewDelegate {
//    func arcViewFrame() -> CGRect
//    func tapPathForPopcornItem(index i:Int, of n:Int) -> UIBezierPath
//}
//
//
//class PopcornMenuView:UIView {
//    var mainArc:CircleView
//    var delegate:PopcornMenuViewDelegate?
//    // Whenever frame changes, update subviews
//    override var frame:CGRect {
//        didSet {
//            adjustFrames()
//        }
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        mainArc = CircleView()
//        super.init(coder: aDecoder)
//    }
//    
//    func adjustFrames() {
//        // TODO: Fix subview layouts
//    }
//    
//    override func drawRect(rect: CGRect) {
//        // TODO: draw button paths
//    }
//    
//    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
//        // TODO: Implement clicker function
//    }
//    
//}

class PopcornButton:UIView {
    var circle:Circle // Outer radius for button
    var angles:AngleRange
    var fringeDepthFactor:CGFloat = 0.2 // Button thickness
    var fillColor:UIColor = UIColor.redColor()
    
    // Calculated properties
    var path:UIBezierPath? {
        get{
            return self.calculatePath()
        }
    }
    private var fringeDepth:CGFloat {
        get {
            return min(frame.width, frame.height) * fringeDepthFactor
        }
    }
    private var innerCircle:Circle {
        get {
            return Circle(radius: circle.radius - fringeDepth,
                            center: circle.center)
        }
    }
    
    
    init(frame:CGRect, circle C:Circle, range:AngleRange) {
        circle = C
        angles = range
        super.init(frame: frame)
    }
    convenience init(frame:CGRect, circle C:Circle) {
        self.init(frame:frame, circle:C, range:AngleRange(start: 0, end: PI/2.0, range: nil))
    }
    convenience override init() {
        self.init(frame: CGRect(x:0, y:0, width:100, height:100))
    }
    convenience override init(frame: CGRect) {
        let aCircle = Circle(radius: min(frame.width, frame.height), center: CGPoint(x: 0,y: 0))
        self.init(frame: frame, circle:aCircle)
    }
    required init(coder aDecoder: NSCoder) {
        circle = Circle(radius: 0, center: CGPoint(x:0,y:0)) // Placeholder
        angles = AngleRange(start: 0, end: PI/2.0, range: nil)
        super.init(coder: aDecoder)
        circle = Circle(radius: min(frame.width, frame.height), center: CGPoint(x: 0,y: 0))
    }
    
    func calculatePath() -> UIBezierPath {
        let out1 = circle.pointOnCircle(2*PI - angles.start)
        let out2 = circle.pointOnCircle(2*PI - angles.end)
        let in1 = innerCircle.pointOnCircle(2*PI - angles.start)
        let in2 = innerCircle.pointOnCircle(2*PI - angles.end)
        
        var p = UIBezierPath()
        p.moveToPoint(out1)
        // Outer arc
        p.addArcWithCenter(circle.center, radius: circle.radius,
                            startAngle: 2*PI - angles.start, endAngle: 2*PI - angles.end,
                            clockwise: true)
        p.addLineToPoint(in2)
        // Inner circle
        p.addArcWithCenter(innerCircle.center, radius: innerCircle.radius,
                            startAngle: 2*PI - angles.end, endAngle: 2*PI - angles.start,
                            clockwise: false)
        p.closePath()
        
        return p
    }
    
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        fillColor.setFill()
        self.path?.fill()
    }
}

