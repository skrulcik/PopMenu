//
//  ViewController.swift
//  PopMenu
//
//  Created by Scott Krulcik on 9/23/14.
//  Copyright (c) 2014 Scott Krulcik. All rights reserved.
//

import UIKit

class MenuController: UIViewController
{

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func panGesture(sender: AnyObject) {
        let pan = sender as UIPanGestureRecognizer
        if(pan.state == UIGestureRecognizerState.Began){
            var point:CGPoint = pan.translationInView(self.view)
            var velocity:CGPoint = pan.velocityInView(self.view)
            println("Vx= \(velocity.x) Vy=\(velocity.y)")
            let myview = view as MenuView
            myview.isShowing = !myview.isShowing && velocity.x<0 && velocity.y<0 //Toggle exploded view
            self.view.setNeedsDisplay()
        }
    }
}
