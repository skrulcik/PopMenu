//
//  MenuView.swift
//  PopMenu
//
//  Created by Scott Krulcik on 9/23/14.
//  Copyright (c) 2014 Scott Krulcik. All rights reserved.
//

import UIKit

let pi = 3.14159265

class MenuView: UIView
{
    var fill_color:UIColor = UIColor(red:100/250.0, green:150/250.0, blue:255/250.0, alpha:1.0)
    var hiddenRadius:Double = 105
    var showRadius:Double = 150
    var buttonRadius:Double = 34
    var isShowing:Bool = false

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawMenuBase()
    }
    
    func drawMenuBase()
    {
        //Set up context for drawing
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSaveGState(ctx)
        
        //Set drawing style
        CGContextSetFillColorWithColor(ctx, fill_color.CGColor)
        CGContextSetStrokeColorWithColor(ctx, fill_color.CGColor)
        
        let corner:CGPoint = CGPointMake(self.frame.size.width, self.frame.size.height)
        var radius = CGFloat(hiddenRadius) //Pixels
        if isShowing{
            radius = CGFloat(showRadius)
            showMenuOptions(ctx)
        }else{
            hideMenuOptions()
        }
        
        //Create Drawing
        CGContextBeginPath(ctx)
        let startAngle = CGFloat(pi/2)
        let endAngle = CGFloat(pi)
        CGContextSetLineWidth(ctx, radius);
        CGContextAddArc(ctx, corner.x, corner.y, radius/2, startAngle, endAngle, 1)
        CGContextStrokePath(ctx)
        //CGContextClosePath(ctx)
        CGContextFillPath(ctx)
        
        //Cleanup Drawing
        CGContextRestoreGState(ctx)
    }
    
    
   /* Presents the buttons (options available to user)
    * Currently draws demo buttons, will eventually be replaced
    * by methods that manage real UIButton objects and control if
    * they are active or not.
    */
    private func showMenuOptions(ctx:CGContextRef)
    {
        let corner:CGPoint = CGPointMake(self.frame.size.width, self.frame.size.height)
        var arcRadius:CGFloat = CGFloat(showRadius + buttonRadius*1.75) //Radius of arc containing menu buttons
        let theta1:CGFloat = CGFloat(pi/10)
        let theta2:CGFloat = CGFloat(pi/4)
        let theta3:CGFloat = CGFloat(4*pi/10)
        
        let buttAX = cos(theta1)*arcRadius*0.97
        let buttAY = sin(theta1)*arcRadius*0.97
        let buttBX = cos(theta2)*arcRadius
        let buttBY = sin(theta2)*arcRadius
        let buttCX = cos(theta3)*arcRadius*0.97
        let buttCY = sin(theta3)*arcRadius*0.97
        
        let A:CGPoint = CGPointMake(CGFloat(corner.x - buttAX), CGFloat(corner.y - buttAY))
        let B:CGPoint = CGPointMake(CGFloat(corner.x - buttBX), CGFloat(corner.y - buttBY))
        let C:CGPoint = CGPointMake(CGFloat(corner.x - buttCX), CGFloat(corner.y - buttCY))
        
        for p:CGPoint in [A,B,C]{
            drawButton(ctx, center: p, radius:buttonRadius)
        }
    }
    
    /* Hides buttons in menu if visible
     * For demo this has no functionality
     * when real buttons are implemented, this will
     * de-activate them.
     */
    private func hideMenuOptions(){
        
    }
    
    /* Draws an individual option button
     * For use with the demo only
     */
    private func drawButton(ctx:CGContextRef, center:CGPoint, radius:Double)
    {
        let edge:CGFloat = CGFloat(2*buttonRadius)
        let leftX:CGFloat = center.x - CGFloat(self.buttonRadius)
        let topY:CGFloat = center.y - CGFloat(self.buttonRadius)
        let rect:CGRect = CGRectMake(leftX, topY, edge, edge);
        CGContextFillEllipseInRect(ctx, rect);
        CGContextFillPath(ctx);
        
    }
}
