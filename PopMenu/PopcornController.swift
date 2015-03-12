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
    func colorForKernel(i:Int) -> UIColor {
        let btn = PopcornButton()
        if i < kernels.count {
            return kernels[i].backgroundColor
        } else {
            NSLog("Warning: attempted to access non-existant kernel")
        }
        return UIColor.clearColor()
    }
    // i is -1 for main menu, 0...(n-1) for the other n popcorn items
    func menuTapped(i:Int) {
        if i == -1 {
            state = (state == .Active) ? .Inactive:.Active
            UIView.animateWithDuration(0.6, animations: {
                self.menu.frame = self.menuFrameForState()
            })
        }
    }
    func  menuFrameForState() -> CGRect{
        var properSize:CGSize
        switch state {
        case .Active :
            properSize = CGSize(width: self.view.frame.width * 0.8, height: self.view.frame.width * 0.8)
        default:
            properSize = CGSize(width: self.view.frame.width * 0.4, height: self.view.frame.width * 0.4)
        }
        let w = properSize.width
        let h = properSize.height
        let pt = CGPoint(x: view.frame.width - w, y: view.frame.height - h)
        return CGRect(origin: pt, size: properSize)
    }
}


