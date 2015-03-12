//
//  PopcornRenderer.swift
//  PopMenu
//
//  Created by Scott Krulcik on 3/11/15.
//  Copyright (c) 2015 Scott Krulcik. All rights reserved.
//

import Foundation
import UIKit

protocol PopcornRendererDelegate {
    var isActive:Bool {get}
    func menuTapped(i:Int) -> Void
    func numKernels() -> Int
    func colorForKernel(i:Int) -> UIColor
}

@IBDesignable
class PopcornRenderer:UIView {
    var delegate:PopcornRendererDelegate?
    var menuColor:UIColor = Color.primary
    
    // Drawing Specs
    @IBInspectable var collapsedSizeRatio:CGFloat = 0.5
    @IBInspectable var actionCircleRatio:CGFloat = 0.7
    @IBInspectable var bufferRatio:CGFloat = 0.1
    var buttonWidthRatio:CGFloat {
        get {
            return 1.0 - actionCircleRatio - bufferRatio
        }
    }
    private var numKernels:Int {
        get {
            if delegate != nil {
                return delegate!.numKernels()
            }
            return 0
        }
    }
    private var isActive:Bool {
        get {
            return true
            if delegate != nil {
                return delegate!.isActive
            }
            return false
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if isActive {
            for i in 0..<numKernels{
                if delegate != nil {
                    delegate!.colorForKernel(i).setFill()
                }
                pathFor(i).fill()
            }
        }
        // Draw arc
        let r = rect.width * actionCircleRatio
        menuColor.setFill()
        let SW = CGPoint(x: rect.width, y: rect.height)
        let path = UIBezierPath()
        path.moveToPoint(SW)
        path.addLineToPoint(CGPoint(x: SW.x - r, y: SW.y))
        path.addArcWithCenter(SW, radius: r, startAngle: PI, endAngle: 3.0*PI/2.0, clockwise: true)
        path.addLineToPoint(SW)
        path.fill()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        action()
    }
    
    
    func action() {
        if self.delegate != nil {
            self.delegate!.menuTapped(-1)
        }
    }
    
    func pathFor(i:Int) -> UIBezierPath {
        let lowRight = AngleRange(start: PI, end: PI/2, range: PI/2)
        let angleRange = ithAngleRange(i, n: numKernels, parentRange: lowRight, bufferAngle: 0.2)
        let k = min(frame.width, frame.height)
        let rOut = k
        let rIn = k * (1 - buttonWidthRatio)
        let SW = CGPoint(x: frame.width, y: frame.height)
        let outside = Circle(radius: rOut, center: SW)
        let inside = Circle(radius: rIn, center: SW)
        return pathForAngle(angleRange, outerCircle: outside, innerCircle: inside)
    }
    
    func pathForAngle(angles:AngleRange, outerCircle circle:Circle, innerCircle:Circle) -> UIBezierPath {
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
    
    func ithAngleRange(i:Int, n:Int,
        parentRange:AngleRange = AngleRange(start: PI/2.0, end: PI, range: nil),
        bufferAngle:CGFloat = 0.2) -> AngleRange {
            let bufferSum = CGFloat(i+1) * bufferAngle // One before each, one at end
            let portion = ( abs(parentRange.end - parentRange.start) - CGFloat(n+1) * bufferAngle) / CGFloat(n)
            let endAt = parentRange.end + CGFloat(i+1)*bufferAngle + CGFloat(i)*portion
            return AngleRange(start: endAt + portion, end: endAt, range: portion)
    }
}