//
//  Menu.swift
//  PopMenu
//
//  Created by Scott Krulcik on 3/8/15.
//  Copyright (c) 2015 Scott Krulcik. All rights reserved.
//

import Foundation
import UIKit

/* A Popcorn is a data object to represent a button of the pop menu
    - A popcorn object is created once, then added to the menu, where it is
        maintained and used to draw draw the buttons, and send commands
    - The delegate is used so that different view controllers can own different 
        pieces of Popcorn in the same menu
    - Color properties are used for rendering. Position and size attributes are
        purposely left up to the popper that manages the Popcorn
*/
struct Popcorn:Equatable, Hashable {
    /* Foreground color for text */
    var color:UIColor?
    /* Background for the radial button representative of this piece */
    var backgroundColor:UIColor?
    /* ViewController that wants to know when button is pressed */
    var delegate:UIViewController
    var id:Int
    var hashValue:Int {
        get {
            return id
        }
    }
}
/* Equality function for Popcorn object */
func ==(lhs: Popcorn, rhs: Popcorn) -> Bool {
    return lhs.delegate == rhs.delegate && lhs.id == rhs.id
}



/* PopcornDelegate is the view controller that wants information when a specific
    popcorn button is pressed */
protocol PopcornDelegate {
    /* Called when Popcorn has first been pressed */
    func menuItemPress(senderID:Int)
    /* Called when finger is released in area of popcorn */
    func menuItemRelease(senderID:Int)
}

enum PopcornMenuState {
    case Inactive, Active
}

/* PopcornPopper is a Popcorn menu controller
 *  It keeps track of pieces of popcorn, and uses them to generate menu items
 */
@IBDesignable
class PopcornPopper:UIViewController {
    @IBInspectable var animationDuration:NSTimeInterval = 0.25
    @IBInspectable var sizeWhenClosed:CGSize = CGSize(width: 100, height: 100)
    @IBInspectable var sizeWhenExpanded:CGSize = CGSize(width: 200, height: 200)
    
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
    private var buttons = Dictionary<Popcorn, PopcornButton>()
    
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
    
    func  menuFrameForState() -> CGRect{
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
    
    func updateMenuForState() {
        UIView.animateWithDuration(animationDuration, animations: {
            self.arcView.frame = self.menuFrameForState()
        })
    }
    
    func toggleState() {
        state = (state == .Active) ? .Inactive:.Active
        updateMenuForState()
    }
}

