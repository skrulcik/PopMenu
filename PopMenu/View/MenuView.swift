//
//  MenuView.swift
//  PopMenu
//
//  Created by Scott Krulcik on 9/23/14.
//  Copyright (c) 2014 Scott Krulcik. All rights reserved.
//

import UIKit

class MenuView: UIView
{
    var hiddenRadius:Int = 100
    var showRadius:Int = 200
    var isShowing:Bool = false

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawMenuBase()
    }
    
    func ﻿﻿()
    {
        let pi = 3.14159265
        let corner:CGPoint = CGPointMake(self.frame.size.width, self.frame.size.height)
        var radius = CGFloat(hiddenRadius) //Pixels
        if isShowing{
            radius = CGFloat(showRadius)
        }
        let startAngle = CGFloat(pi/2)
        let endAngle = CGFloat(pi)
        
        //Set up context for drawing
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSaveGState(ctx)
        
        
        //Set drawing style
        CGContextSetLineWidth(ctx, radius);
        CGContextSetRGBFillColor(ctx, 100/250.0, 150/250.0, 255/250.0, 1.0)
        CGContextSetRGBStrokeColor(ctx, 100/250.0, 150/250.0, 255/250.0, 1.0)
        
        //Create Drawing
        CGContextBeginPath(ctx)
        CGContextAddArc(ctx, corner.x, corner.y, radius/2, startAngle, endAngle, 1)
        CGContextStrokePath(ctx)
        //CGContextClosePath(ctx)
        CGContextFillPath(ctx)
        
        //Cleanup Drawing
        CGContextRestoreGState(ctx)
    }
}
