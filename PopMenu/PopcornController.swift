//
//  PopcornController.swift
//  PopMenu
//
//  Created by Scott Krulcik on 3/11/15.
//  Copyright (c) 2015 Scott Krulcik. All rights reserved.
//

import Foundation
import UIKit

enum PopcornMenuState {
    case Inactive, Active
}

class PopcornController:UIViewController, PopcornRendererDelegate {
    var menu:PopcornRenderer
    var state:PopcornMenuState = .Inactive
    
    // MARK: PopcornRendererDelegate properties
    var kernels:Array<Popcorn>
    var isActive:Bool {
        get {
            return state == .Active
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        kernels = [Popcorn]()
        // For testing only
        let p1 = Popcorn(backgroundColor: UIColor.redColor())
        let p2 = Popcorn(backgroundColor: UIColor.blueColor())
        kernels = [p1, p2]
        self.menu = PopcornRenderer()
        super.init(coder: aDecoder)
        self.menu.delegate = self
    }
    
    override init() {
        kernels = [Popcorn]()
        // For testing only
        let p1 = Popcorn(backgroundColor: UIColor.redColor())
        let p2 = Popcorn(backgroundColor: UIColor.blueColor())
        kernels = [p1, p2]
        self.menu = PopcornRenderer()
        super.init()
        self.menu.delegate = self
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        kernels = [Popcorn]()
        // For testing only
        let p1 = Popcorn(backgroundColor: UIColor.redColor())
        let p2 = Popcorn(backgroundColor: UIColor.blueColor())
        kernels = [p1, p2]
        self.menu = PopcornRenderer()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.menu.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.frame = menuFrameForState()
        menu.backgroundColor = UIColor.whiteColor()
        view.addSubview(menu)
        menu.setNeedsDisplay()
    }
    
    // PopcornRendererDelegate
    func numKernels() -> Int {
        return kernels.count
    }
    func buttonForIndex(i:Int) -> PopcornButton {
        let btn = PopcornButton()
        if i < kernels.count {
            btn.backgroundColor = UIColor.clearColor()
            btn.fillColor = kernels[i].backgroundColor
            btn.angles = ithAngleRange(i, n: kernels.count)
        } else {
            NSLog("Warning: attempted to access non-existant kernel")
        }
        return btn
    }
    func menuTapped() {
        state = (state == .Active) ? .Inactive:.Active
        UIView.animateWithDuration(0.6, animations: {
            self.menu.frame = self.menuFrameForState()
        })
    }
    func  menuFrameForState() -> CGRect{
        var properSize:CGSize
        switch state {
        case .Active :
            properSize = CGSize(width: self.view.frame.width * 0.6, height: self.view.frame.width * 0.6)
        default:
            properSize = CGSize(width: self.view.frame.width * 0.2, height: self.view.frame.width * 0.2)
        }
        let w = properSize.width
        let h = properSize.height
        let pt = CGPoint(x: view.frame.width - w, y: view.frame.height - h)
        return CGRect(origin: pt, size: properSize)
    }
    
    func ithAngleRange(i:Int, n:Int,
                        parentRange:AngleRange = AngleRange(start: PI/2.0, end: PI, range: nil),
                        bufferAngle:CGFloat = 0.2) -> AngleRange {
        let bufferSum = CGFloat(n + 1) * bufferAngle // One before each, one at end
        let portion = (parentRange.end - parentRange.start) / CGFloat(n)
        let startAt = parentRange.start + CGFloat(n+1)*bufferAngle + CGFloat(n)*portion
        return AngleRange(start: startAt, end: startAt + portion, range: portion)
    }
    
}


