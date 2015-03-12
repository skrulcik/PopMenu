//
//  Menu.swift
//  PopMenu
//
//  Created by Scott Krulcik on 3/8/15.
//  Copyright (c) 2015 Scott Krulcik. All rights reserved.
//

import Foundation
import UIKit

/* PopcornPopper is a Popcorn menu controller
 *  It keeps track of pieces of popcorn, and uses them to generate menu items
 */
@IBDesignable
class PopcornMenu:UIViewController {
    @IBInspectable var fringeRatio:CGFloat = 0.2 // Portion of view dedicated to popcorn
    @IBInspectable var animationDuration:NSTimeInterval = 0.15
    @IBInspectable var sizeWhenClosed:CGSize = CGSize(width: 160, height: 160)
    @IBInspectable var sizeWhenExpanded:CGSize = CGSize(width: 400, height: 400)
    
    // describes the drawing and interaction state of the menu
    var state:PopcornMenuState = .Inactive {
        didSet {
            updateMenuForState()
        }
    }
    var menuColor:UIColor = UIColor.blueColor()
    var kernels:Array<Popcorn> = [] {
        didSet {
            self.reloadInputViews()
        }
    }
    
    // Private views used to illustrate menu
    private var arcView:CircleView
    
    required init(coder aDecoder: NSCoder) {
        arcView = CircleView(centerStyle: .SE)
        super.init(coder: aDecoder)
    }
    override init() {
        arcView = CircleView(centerStyle: CirclePosition.SE)
        super.init()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        arcView = CircleView(centerStyle: .SE)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        arcView.frame = menuFrameForState()
        self.view.addSubview(arcView)
        
        arcView.addTarget(self, action:"toggleState" , forControlEvents: .TouchUpInside)
    }
    
    func updateMenuForState() {
        UIView.animateWithDuration(animationDuration, animations: {
            self.arcView.frame = self.menuFrameForState()
        })
    }
    
    func toggleState() {
        state = (state == .Active) ? .Inactive:.Active
        updateMenuForState()
    }
    
    //MARK: Drawing Calculations
    private func  menuFrameForState() -> CGRect{
        var properSize:CGSize
        switch state {
        case .Active :
            properSize = sizeWhenExpanded
        default:
            properSize = sizeWhenClosed
        }
        let w = properSize.width
        let h = properSize.height
        let pt = CGPoint(x: view.frame.width - w, y: view.frame.height - h)
        return CGRect(origin: pt, size: properSize)
    }
    
    func arcViewFrame() -> CGRect {
        let largeFrame = menuFrameForState()
        let axis = min(largeFrame.width, largeFrame.height) * (1 - fringeRatio)
        var menuFrame = CGRectInset(largeFrame, axis, axis) // Make frame smaller
        menuFrame = menuFrame.rectByOffsetting(dx: axis, dy: axis) // Offset frame to still be in the bottom right
        return menuFrame
    }
    func tapPathForPopcornItem(index i:Int, of n:Int) -> UIBezierPath {
        if state == .Active {
            
            let angles = angleRangeForPopcornItem(index: i, of:n)
            let largeFrame = menuFrameForState()
            let circle = Circle(radius: min(largeFrame.width, largeFrame.height),
                center: CGPoint(x: largeFrame.maxX, y: largeFrame.maxY))
            let innerCircle = Circle.insetCircle(circle, dr: circle.radius*fringeRatio)
            
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
        } else {
            return UIBezierPath()
        }
    }
    func angleRangeForPopcornItem(index i:Int, of n:Int) -> AngleRange {
        return AngleRange(start: 3.0, end: 2.0, range: nil)
    }
}

