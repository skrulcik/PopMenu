//
//  Util.swift
//  PopMenu
//
//  Created by Scott Krulcik on 3/10/15.
//  Copyright (c) 2015 Scott Krulcik. All rights reserved.
//

import Foundation
import UIKit

let PI:CGFloat = CGFloat(M_PI)

/* Standard circle object */
struct Circle {
    var radius:CGFloat
    var center:CGPoint
    func pointOnCircle(var angle:CGFloat, inDegrees:Bool = false) -> CGPoint{
        // Note: "var" in parameter name makes it mutable
        if inDegrees {
            angle = angle / (2*PI)
        }
        let newX = center.x + radius * cos(angle)
        let newY = center.y + radius * sin(angle)
        return CGPoint(x: newX, y: newY)
    }
    
    /* Requires param dr <= c.radius */
    static func insetCircle(c:Circle, dr:CGFloat) -> Circle {
        return Circle(radius: c.radius - dr, center: c.center)
    }
}

/* Represents a range of angles,
* Changing the end angle automatically changes the range
* Changing the range automatically changes the end angle
*/
struct AngleRange {
    var start:CGFloat
    var end:CGFloat {
        didSet {
            range = end - start
        }
    }
    var range:CGFloat? {
        didSet {
            if range != nil {
                end = start + range!
            }
        }
    }
}


class BezierView:UIView {
    var path:UIBezierPath
    
    required init(coder aDecoder: NSCoder) {
        path = UIBezierPath()
        super.init(coder: aDecoder)
    }
    init(frame:CGRect, path:UIBezierPath){
        self.path = path
        super.init(frame: frame)
    }
    convenience override init(frame: CGRect) {
        self.init(frame:frame, path:UIBezierPath())
    }
    convenience override init() {
        self.init(frame:CGRectZero)
    }
    
    override func drawRect(rect: CGRect) {
        let tempColor = backgroundColor // Preserve for drawing
        backgroundColor = UIColor.clearColor() // Draw clear
        super.drawRect(rect)
        backgroundColor = tempColor
        backgroundColor?.setFill()
        self.path.fill()
    }
}




