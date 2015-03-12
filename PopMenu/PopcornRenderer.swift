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
    func menuTapped() -> Void
    func numKernels() -> Int
    func buttonForIndex(i:Int) -> PopcornButton
}

@IBDesignable
class PopcornRenderer:UIView {
    var delegate:PopcornRendererDelegate?
    var menuColor:UIColor = UIColor.blueColor()
    
    // Drawing Specs
    @IBInspectable var collapsedSizeRatio:CGFloat = 0.5
    @IBInspectable var actionCircleRatio:CGFloat = 0.7
    @IBInspectable var bufferRatio:CGFloat = 0.1
    var buttonWidthRatio:CGFloat {
        get {
            return 1.0 - actionCircleRatio - bufferRatio
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if delegate != nil && delegate!.isActive {
            
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
            self.delegate!.menuTapped()
        }
    }
}